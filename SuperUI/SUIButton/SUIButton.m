//
//  SUIButton.m
//  OfficeReader
//
//  Created by OpenThread on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SUIButton.h"

@implementation SUIButton

- (UIButton *)button
{
    return _innerButton;
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    [_innerButton addTarget:target action:action forControlEvents:controlEvents];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _innerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _innerButton.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:_innerButton];
        self.userInteractionEnabled = YES;
    }
    return self;
}

@end
