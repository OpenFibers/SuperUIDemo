//
//  SUIInnerTextView.m
//  snstaoban
//
//  Created by OpenThread on 12/15/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import "SUIInnerTextView.h"

@implementation SUIInnerTextView

@synthesize animationDuration = _animationDuration;
@synthesize animationDelay = _animationDelay;

//解决文字上漂问题
-(void)setContentOffset:(CGPoint)newContentOffset
{
    newContentOffset.y = 0;
    [super setContentOffset:newContentOffset];
}

-(void)setContentInset:(UIEdgeInsets)newEdgeInsets
{
	[super setContentInset:UIEdgeInsetsZero];
}


@end
