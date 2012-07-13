//
//  SUIGrowableScrollView.m
//  snstaoban
//
//  Created by OpenThread on 12/19/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import "SUIGrowableScrollView.h"

@implementation SUIGrowableScrollView

@synthesize suiScrollEnable = _suiScrollEnable;

- (void)setContentOffset:(CGPoint)contentOffset
{
    //重写此方法在_suiScrollEnable为NO的时候禁用系统的setContentOffset调用以解决4.3中第一行为空输入回车时产生的漂移问题
    if (_suiScrollEnable) {
        [super setContentOffset:contentOffset];
    }
}

- (void)setGrowableContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset:contentOffset];
}

@end
