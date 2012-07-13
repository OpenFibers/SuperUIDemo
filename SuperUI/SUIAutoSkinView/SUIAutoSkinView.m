//
//  SUIAutoSkinView.m
//  YXPiOSClient
//
//  Created by openthread on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SUIAutoSkinView.h"
#import "SUIAutoSkinManager.h"
#import "SUIAutoSkinViewModel.h"

@implementation SUIAutoSkinView
{
    NSMutableArray *_modelArray;
}

- (void)setAutoSkinImageName:(NSString *)autoSkinImageName forState:(UIControlState)state;
{
    for (int i = _modelArray.count - 1; i >= 0; i--)
    {
        if (i >= 0)
        {
            if (((SUIAutoSkinViewModel *)[_modelArray objectAtIndex:i]).state == state)
            {
                [_modelArray removeObjectAtIndex:i];
            }
        }
    }
    if (autoSkinImageName && autoSkinImageName.length != 0)
    {
        SUIAutoSkinViewModel *model = [SUIAutoSkinViewModel newAutoSkinModel];
        model.autoSkinImageName = autoSkinImageName;
        model.state = state;
        model.autoSkinView = self;
        [_modelArray addObject:model];
        [SUIAutoSkinManager addAutoSkinModel:model];
    }
}

- (void)changeSkinImageTo:(UIImage *)image forState:(UIControlState)state
{
    //Empty Method to be override
}

#pragma mark - Life Cycle

- (id)init
{
    self = [self initWithFrame:CGRectZero];
    if (self)
    {
        ;;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _modelArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
    for (SUIAutoSkinViewModel *eachModel in _modelArray)
    {
        [SUIAutoSkinManager removeAutoSkinModel:eachModel];
    }
}

@end
