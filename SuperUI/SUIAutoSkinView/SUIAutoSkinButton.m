//
//  SUIAutoSkinButton.m
//  YXPiOSClient
//
//  Created by openthread on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SUIAutoSkinButton.h"

@implementation SUIAutoSkinButton
{
    UIButton *_innerButton;
}

- (void)layoutSubviews
{
    _innerButton.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _innerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _innerButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:_innerButton];
    }
    return self;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [_innerButton setTitle:title forState:state];
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [_innerButton addTarget:target action:action forControlEvents:controlEvents];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [_innerButton setImage:image forState:UIControlStateNormal];
}

- (void)changeSkinImageTo:(UIImage *)image forState:(UIControlState)state
{
    [_innerButton setImage:image forState:state];
    [super changeSkinImageTo:image forState:state];
}

@end
