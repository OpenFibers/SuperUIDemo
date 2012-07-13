//
//  SUIAutoSkinView.h
//  YXPiOSClient
//
//  Created by openthread on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SUIAutoSkinView : UIView

//设置自动更换的皮肤名字
- (void)setAutoSkinImageName:(NSString *)autoSkinImageName forState:(UIControlState)state;

//在需要更换皮肤时被调用，重载此方法刷新视图
- (void)changeSkinImageTo:(UIImage *)image forState:(UIControlState)state;

@end
