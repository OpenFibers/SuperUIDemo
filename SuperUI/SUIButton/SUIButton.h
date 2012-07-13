//
//  SUIButton.h
//  OfficeReader
//
//  Created by OpenThread on 4/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//  此类可以让按钮在Core Animation中调整Frame时，Background Image具有动画效果

#import <UIKit/UIKit.h>

@interface SUIButton : UIImageView
{
    UIButton *_innerButton;
}

@property (nonatomic,retain,readonly) UIButton *button;

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
