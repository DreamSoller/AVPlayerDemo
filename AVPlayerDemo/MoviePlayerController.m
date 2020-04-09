//
//  NSObject+PlayerController.m
//  AVPlayerDemo
//
//  Created by NCIT Mobile Desktop on 2019/5/20.
//  Copyright © 2019 NCIT Mobile Desktop. All rights reserved.
//

#import "MoviePlayerController.h"

typedef NS_ENUM(NSInteger, PlayerStatu){
    None,
    End,
    Play,
    Pause
};

@interface MoviePlayerController()
{
    PlayerStatu _playStatus;
}

@property (nonatomic, strong) AVPlayerLayer* playerLayer;

@property (nonatomic, assign) CGFloat currentItemDuration;

@property (nonatomic, assign) CGFloat fps;

@end

@implementation MoviePlayerController

- (id)init
{
    self = [super init];
    if (self) {
        // TODO
        self.player = [[AVPlayer alloc] init];
    }
    return self;
}

- (void)replacePlayerItemWithURL: (NSString*)url
{
    NSURL* mediaURL = [NSURL URLWithString:url];
    AVPlayerItem* playerItem = [[AVPlayerItem alloc] initWithURL:mediaURL];
    self.currentItemDuration = CMTimeGetSeconds(playerItem.asset.duration);
    self.fps = [[[playerItem.asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] nominalFrameRate];
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    [self.player play];
    _playStatus = Play;
    self.player.volume = 1.0f;
    self.player.rate = 1.0f;
}

- (AVPlayerLayer*)playerLayerWithRect: (CGRect)rect
{
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    //视频填充模式
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    self.playerLayer.frame = rect;
    self.playerLayer.backgroundColor = [UIColor blackColor].CGColor;
    return self.playerLayer;
}

// 添加当前播放进度的监听事件
- (void)addPeriodicTimeObserver
{
    [self.viewDelegate setTotalPlayDuration:self.currentItemDuration];
    CMTime interval = self.currentItemDuration > 60 ? CMTimeMake(1, 1) : CMTimeMake(1, 30);
    __weak typeof(self) weakSelf = self;
    [self.player addPeriodicTimeObserverForInterval:interval queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //
        if (!weakSelf.viewDelegate.isSliding){
            CGFloat currentTime = CMTimeGetSeconds(time);
            [weakSelf.viewDelegate updatePlayProgress:currentTime];
        }
    }];
}

- (void)play
{
    if (_playStatus == Pause) {
        [self.player play];
        _playStatus = Play;
        [self.viewDelegate.playButton setImage:[UIImage imageNamed:@"./Images/btn_stop.png"] forState:UIControlStateNormal];
    } else if (_playStatus == Play) {
         [self.player pause];
        _playStatus = Pause;
        [self.viewDelegate.playButton setImage:[UIImage imageNamed:@"./Images/btn_play.png"] forState:UIControlStateNormal];
    } else {
        
    }
   
}

- (void)handleSliderTouchDown
{
    [self.player pause];
    _playStatus = Pause;
}

- (void)handleSliderTouchUp
{
    [self.player play];
    _playStatus = Play;
}

- (void)handleSlide:(double)slideValue
{
    CMTime time = CMTimeMakeWithSeconds(self.currentItemDuration * slideValue, self.fps);
    [self.player seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

@end
