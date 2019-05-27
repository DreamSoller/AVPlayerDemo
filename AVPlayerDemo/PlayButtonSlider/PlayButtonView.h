//
//  UIView+PlayButtonView.h
//  AVPlayerDemo
//
//  Created by NCIT Mobile Desktop on 2019/5/22.
//  Copyright © 2019 NCIT Mobile Desktop. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlayButtonViewDelegate

- (void)play;

- (void)handleSliderTouchDown;

- (void)handleSliderTouchUp;

- (void)handleSlide:(double)slideValue;

@end

@interface PlayButtonView : UIView

@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property (weak, nonatomic) IBOutlet UILabel *currentDuration;

@property (weak, nonatomic) IBOutlet UILabel * totalDuration;

@property (weak, nonatomic) IBOutlet UISlider *progressSlider;

@property (weak, nonatomic) IBOutlet UIButton *fullScreenButton;

@property (nonatomic, weak) id<PlayButtonViewDelegate> delegate;

@property (nonatomic) BOOL isSliding;

- (IBAction)doPlay:(id)sender;

- (void)setTotalPlayDuration:(CGFloat)time;

- (void)updatePlayProgress:(CGFloat)time;

@end

