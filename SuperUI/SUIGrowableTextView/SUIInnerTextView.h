//
//  SUIInnerTextView.h
//  snstaoban
//
//  Created by OpenThread on 12/15/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SUIInnerTextView : UITextView
{
    NSTimeInterval _animationDuration; 
    NSTimeInterval _animationDelay;
}

/*
 The animation time when this control change its size.
 */
@property (nonatomic,assign) NSTimeInterval animationDuration;

/*
 The animation delay time when this control change its size.
 */
@property (nonatomic,assign) NSTimeInterval animationDelay;

@end
