//
//  SUITwinkleLabel.h
//  Pomodoro
//
//  Created by OpenThread on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

// WARNING:This label only support Left Alignment
// WARNING:You must invoke stopTwinkle method before remove it.Or the app will crash.

#import <UIKit/UIKit.h>
@class LabelDelegate;

@interface SUITwinkleLabel : UILabel
{
    CGFloat _gradientLocations[3];
    int animationTimerCount;
    NSTimer *_animationTimer;
    LabelDelegate *_labelDelegate;
}

@property (nonatomic,readonly,assign) CGFloat *gradientLocations;
@property (nonatomic,readonly,retain) NSTimer *animationTimer;

- (void)startTwinkle;
- (void)stopTwinkle;

@end
