//
//  ViewController.m
//  AVPlayerDemo
//
//  Created by NCIT Mobile Desktop on 2019/5/20.
//  Copyright © 2019 NCIT Mobile Desktop. All rights reserved.
//

#import "MoviePlayViewController.h"
#import "PlayButtonSlider/PlayButtonView.h"

@interface MoviePlayViewController ()
{
}
@property (nonatomic, retain) MoviePlayerController* player;
@property (nonatomic, strong) PlayButtonView* playButtonView;

@end

@implementation MoviePlayViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // 播放器初始化
    _player = [[MoviePlayerController alloc] init];
    [_player replacePlayerItemWithURL:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"];
    // 播放layer初始化
    CGRect rect = CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.height * 0.5);
    AVPlayerLayer* playerLayer = [_player playerLayerWithRect:rect];
    [self.view.layer addSublayer:playerLayer];
    // 播放控制view初始化
    _playButtonView = [[[NSBundle mainBundle] loadNibNamed:@"PlayButtonView" owner:self options:nil] firstObject];
    [_playButtonView setFrame:CGRectMake(0.0, self.view.frame.size.height * 0.5 - 50, self.view.frame.size.width, 50)];
    [self.view addSubview:_playButtonView];
    _player.viewDelegate = _playButtonView;
    
    _playButtonView.delegate = _player;
    
    [_player addPeriodicTimeObserver];
}

@end
