//
//  SUIAutoSkinViewModel.m
//  YXPiOSClient
//
//  Created by openthread on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SUIAutoSkinViewModel.h"

@implementation SUIAutoSkinViewModel

@synthesize autoSkinImageName = _autoSkinImageName;

@synthesize state = _state;

@synthesize autoSkinView = _autoSkinView;

+ (SUIAutoSkinViewModel *)newAutoSkinModel
{
    SUIAutoSkinViewModel *model = [[SUIAutoSkinViewModel alloc] init];
    return model;
}

@end
