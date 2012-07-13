//
//  SUIAutoSkinButton.h
//  YXPiOSClient
//
//  Created by openthread on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUIAutoSkinView.h"

@interface SUIAutoSkinButton : SUIAutoSkinView

- (void)setTitle:(NSString *)title forState:(UIControlState)state;

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

- (void)setImage:(UIImage *)image forState:(UIControlState)state;

@end
