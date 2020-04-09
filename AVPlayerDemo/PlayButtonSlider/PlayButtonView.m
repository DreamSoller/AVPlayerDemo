//
//  UIView+PlayButtonView.m
//  AVPlayerDemo
//
//  Created by NCIT Mobile Desktop on 2019/5/22.
//  Copyright © 2019 NCIT Mobile Desktop. All rights reserved.
//

#import "PlayButtonView.h"

@interface PlayButtonView ()
{
    CGFloat _duration;
}

@end

@implementation PlayButtonView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.progressSlider setThumbImage:[UIImage imageNamed:@"./Images/progress_dot.png"] forState:UIControlStateNormal];
    [self.playButton setImage:[UIImage imageNamed:@"./Images/btn_stop.png"] forState:UIControlStateNormal];
    [self.fullScreenButton setImage:[UIImage imageNamed:@"./Images/noScreen.png"] forState:UIControlStateNormal];
    self.isSliding = NO;
    
    [self.progressSlider addTarget:self action:@selector(handleSliderTouchDown:) forControlEvents:UIControlEventTouchDown];
    [self.progressSlider addTarget:self action:@selector(handleSlide:) forControlEvents:UIControlEventValueChanged];
    [self.progressSlider addTarget:self action:@selector(handleSliderTouchUp:) forControlEvents:UIControlEventTouchUpInside];
    [self.progressSlider addTarget:self action:@selector(handleSliderTouchUp:) forControlEvents:UIControlEventTouchUpOutside];
    [self.progressSlider addTarget:self action:@selector(handleSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}

#pragma mark - SliederAction
- (void)handleSliderTouchDown:(UISlider *)slider{
    NSLog(@"TouchDown");
    self.isSliding = YES;
    if (self.delegate != nil) {
        [self.delegate handleSliderTouchDown];
    }
//    _tap.enabled = NO;
//    _isSliding = YES;
//    if(_playerStatu == Play){
//        [_player pause];
//    }
}

- (void)handleSliderTouchUp:(UISlider *)slider{
    NSLog(@"TouchUp");
    self.isSliding = NO;
    if (self.delegate != nil) {
        [self.delegate handleSliderTouchUp];
    }
//    NSLog(@"TouchUp");
//    _tap.enabled = YES;
//    _isSliding = NO;
//    if(_playerStatu == Play){
//        [_player play];
//    }
}

- (void)handleSlide:(UISlider *)slider
{
    NSString *timeText = [self convertTimeToString:(_duration * slider.value)];
    [self.currentDuration setText:timeText];
    if (self.delegate != nil) {
        [self.delegate handleSlide:slider.value];
    }
//    CMTime time = CMTimeMakeWithSeconds(_duration * slider.value, _fps);
//
//    NSString *timeText = [NSString stringWithFormat:@"%@/%@", [self convert:_duration * slider.value], [self convert:_duration]];
//    _bottomView.timeLabel.text = timeText;
//
//    [_player seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

- (void)handleSliderValueChanged:(UISlider *)slider
{
    [self.currentDuration setText:[self convertTimeToString:slider.value * _duration]];
   
}

- (IBAction)doPlay:(id)sender
{
    [self.delegate play];
}

- (void)setTotalPlayDuration:(CGFloat)time
{
    _duration = time;
    [self.totalDuration setText:[self convertTimeToString:time]];
}

- (void)updatePlayProgress:(CGFloat)time
{
    [self.currentDuration setText:[self convertTimeToString:time]];
    self.progressSlider.value = time / _duration;
}

- (NSString*)convertTimeToString:(CGFloat)time
{
    NSInteger hour = time / 3600;
    NSInteger minute = (time  - hour * 3600) / 60;
    NSInteger second = time  - (hour * 3600) - (minute * 60);
    NSString* hourString = [NSString stringWithFormat:@"%02zd",hour];
    NSString* minuteString = [NSString stringWithFormat:@"%02zd",minute];
    NSString* secondString = [NSString stringWithFormat:@"%02zd",second];
    return [NSString stringWithFormat:@"%@:%@:%@", hourString, minuteString, secondString];
}

@end
