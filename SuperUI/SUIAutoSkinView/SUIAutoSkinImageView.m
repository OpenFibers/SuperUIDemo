//
//  SUIAutoSkinImageView.m
//  YXPiOSClient
//
//  Created by openthread on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SUIAutoSkinImageView.h"

@implementation SUIAutoSkinImageView
{
    UIImageView *_innerImageView;
}

- (void)layoutSubviews
{
    _innerImageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

- (UIImage *)image
{
    return _innerImageView.image;
}

- (void)setImage:(UIImage *)image
{
    _innerImageView.image = image;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _innerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:_innerImageView];
    }
    return self;
}

- (void)changeSkinImageTo:(UIImage *)image forState:(UIControlState)state
{
    _innerImageView.image = image;
    [super changeSkinImageTo:image forState:state];
}

@end
