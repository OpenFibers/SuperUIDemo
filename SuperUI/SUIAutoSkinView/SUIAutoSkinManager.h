//
//  SUIAutoSkinViewKeeper.h
//  YXPiOSClient
//
//  Created by openthread on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SUIAutoSkinViewModel;

@protocol SUIAutoSkinDelegate <NSObject>

@optional
- (void)changeSkinFinished;//皮肤刷新完成时的回调

@end

@interface SUIAutoSkinManager : NSObject

+ (void)setDelegate:(id<SUIAutoSkinDelegate>)delegate;

+ (void)addAutoSkinModel:(SUIAutoSkinViewModel *)autoSkinModel;

+ (void)removeAutoSkinModel:(SUIAutoSkinViewModel *)autoSkinModel;

+ (BOOL)changeSkinPath:(NSString *)skinFolderPath;

@end
