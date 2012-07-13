//
//  SUIUnlockSlider.m
//  Pomodoro
//
//  Created by OpenThread on 12/6/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SUIUnlockSlider.h"
#import <QuartzCore/QuartzCore.h>
#import "OTRuntime.h"

@implementation SUIUnlockSlider

- (NSString *)titleString
{
    return _label.text;
}

- (void)setTitleString:(NSString *)titleString
{
    _label.text = titleString;
    UIFont *labelFont = [UIFont systemFontOfSize:24];
    CGSize labelSize = [titleString sizeWithFont:labelFont];
    _label.frame = CGRectMake(0.0, 0.0, labelSize.width, labelSize.height);
    CGFloat labelHorizontalCenter = self.frame.size.width / 2 + (_thumbImage.size.width / 2);
    _label.center = CGPointMake(labelHorizontalCenter, self.frame.size.height / 2);
}

- (void)addSlideToEndEventTarget:(id)target selector:(SEL)selector
{
    _argCountOfSelector = sel_getArgumentsCount(selector);
    NSAssert(_argCountOfSelector <= 1, @"Selector arguments count up to 1");
    _target = target;
    _selector = selector;
}

- (void)reset
{
    [self setValue:0.0 animated:NO];
    _label.alpha = 1.0;
    [_label startTwinkle];
}

- (id)initWithFrame:(CGRect)frame titleString:(NSString *)titleString
{
    self = [self initWithFrame:frame];
    if (self)
    {
        self.titleString = titleString;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 44.0f);
    self = [super initWithFrame:newFrame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self setMinimumTrackImage:[UIImage imageNamed:@"sliderMaxMin-02.png"] forState:UIControlStateNormal];
        [self setMaximumTrackImage:[UIImage imageNamed:@"sliderMaxMin-02.png"] forState:UIControlStateNormal];
        _thumbImage = [UIImage imageNamed:@"sliderThumb.png"];
        [self setThumbImage:_thumbImage forState:UIControlStateNormal];
        self.minimumValue = 0.0;
        self.maximumValue = 1.0;
        self.continuous = YES;
        self.value = 0.0;
        [self addTarget:self action:@selector(sliderUp:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(sliderDown:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
        
        CGRect labelRect = CGRectMake(0.0, 0.0, newFrame.size.width - _thumbImage.size.width, 24);
        _label = [[SUITwinkleLabel alloc] initWithFrame:labelRect];
        _label.textColor = [UIColor whiteColor];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont systemFontOfSize:24.0f];
        [self addSubview:_label];
        [_label startTwinkle];
    }
    return self;
}

- (void) sliderUp: (UISlider *) sender
{
	//filter out duplicate sliderUp events
	if (touchIsDown) {
		touchIsDown = NO;
		
		if (self.value != 1.0)  //if the value is not the max, slide this bad boy back to zero
		{
			[self setValue: 0 animated: YES];
			_label.alpha = 1.0;
			[_label startTwinkle];
		}
		else {
			//tell the delagate we are slid all the way to the right
            if (_target) {
                if (_argCountOfSelector == 0) {
                    objc_msgSend(_target, _selector);
                }
                else if (_argCountOfSelector == 1)
                {
                    objc_msgSend(_target, _selector, self);
                }
            }
		}
	}
}

- (void) sliderDown: (UISlider *) sender
{
	touchIsDown = YES;
}

- (void) sliderChanged: (UISlider *) sender
{
	// Fade the text as the slider moves to the right. This code makes the
	// text totally dissapear when the slider is 35% of the way to the right.
	_label.alpha = MAX(0.0, 1.0 - (self.value * 3.5));
	
	// Stop the animation if the slider moved off the zero point
	if (self.value != 0) {
		[_label stopTwinkle];
	}
}

- (void)removeFromSuperview
{
    [_label stopTwinkle];
    [super removeFromSuperview];
}

@end
