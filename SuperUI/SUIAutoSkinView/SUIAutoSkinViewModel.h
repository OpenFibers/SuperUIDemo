//
//  SUIAutoSkinViewModel.h
//  YXPiOSClient
//
//  Created by openthread on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SUIAutoSkinView;

@interface SUIAutoSkinViewModel : NSObject

@property (nonatomic,retain) NSString *autoSkinImageName;

@property (nonatomic,assign) UIControlState state;

@property (nonatomic,assign) SUIAutoSkinView *autoSkinView;

+ (SUIAutoSkinViewModel *)newAutoSkinModel;

@end
