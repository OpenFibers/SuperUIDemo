//
//  SUIUnlockSlider.h
//  Pomodoro
//
//  Created by OpenThread on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//


//  WARNING:Height of this control will be forcely set to 44.


#import <UIKit/UIKit.h>
#import "SUITwinkleLabel.h"


@interface SUIUnlockSlider : UISlider
{
    BOOL touchIsDown;
    SUITwinkleLabel *_label;
    UIImage *_thumbImage;
    __unsafe_unretained id _target;
    SEL _selector;
    int _argCountOfSelector;
}


//Add target and selector for slide to end event.
//WARNING:The selector should not take more than 1 parameter.Or an NSAssert will come out.
//If the selector take 1 param, the only param will be the slider it self.
- (void)addSlideToEndEventTarget:(id)target selector:(SEL)selector;

//Set the value to 0.
- (void)reset;

//Init with a frame with constant height of 44, and a twinkle label string.
- (id)initWithFrame:(CGRect)frame titleString:(NSString *)titleString;

//Return title string of unlock slider.
@property (nonatomic,assign) NSString *titleString;

@end
