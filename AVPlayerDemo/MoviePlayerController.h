//
//  NSObject+PlayerController.h
//  AVPlayerDemo
//
//  Created by NCIT Mobile Desktop on 2019/5/20.
//  Copyright © 2019 NCIT Mobile Desktop. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "PlayButtonSlider/PlayButtonView.h"
@interface MoviePlayerController : NSObject <PlayButtonViewDelegate>

@property (nonatomic, strong) AVPlayer* player;

@property (nonatomic, weak) PlayButtonView* viewDelegate;

- (void)replacePlayerItemWithURL: (NSString*)url;

- (AVPlayerLayer*)playerLayerWithRect: (CGRect)rect;

- (void)addPeriodicTimeObserver;

@end

