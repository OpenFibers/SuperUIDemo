//
//  SUIAutoSkinViewKeeper.m
//  YXPiOSClient
//
//  Created by openthread on 6/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SUIAutoSkinManager.h"
#import "SUIAutoSkinViewModel.h"
#import "SUIAutoSkinView.h"

@implementation SUIAutoSkinManager
{
    NSMutableArray *_autoSkinArray;
    NSString *_currentSkinFolderPath;
    id<SUIAutoSkinDelegate> _delegate;
    NSThread *_changingAllSkinThread;
}

#pragma mark - Skin Model Methods

- (void)updateSkinModel:(SUIAutoSkinViewModel *)model
{
    NSString *imagePath = [_currentSkinFolderPath stringByAppendingPathComponent:model.autoSkinImageName];
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    [model.autoSkinView changeSkinImageTo:image forState:model.state];
}

- (void)refreshAllSkinModel
{
    @autoreleasepool
    {
        @synchronized(_autoSkinArray)
        {
            for (SUIAutoSkinViewModel *eachModel in _autoSkinArray)
            {
                [self updateSkinModel:eachModel];
            }
            if (_delegate && [_delegate respondsToSelector:@selector(changeSkinFinished)])
            {
                [_delegate changeSkinFinished];
            }
        }
    }
}

- (void)instanceAddAutoSkinModel:(SUIAutoSkinViewModel *)autoSkinModel
{
    @synchronized(_autoSkinArray)
    {
        [_autoSkinArray addObject:autoSkinModel];
        [self updateSkinModel:autoSkinModel];
    }
}

+ (void)addAutoSkinModel:(SUIAutoSkinViewModel *)autoSkinModel;
{
    [[SUIAutoSkinManager sharedInstance] instanceAddAutoSkinModel:autoSkinModel];
}

- (void)instanceRemoveAutoSkinModel:(SUIAutoSkinViewModel *)autoSkinModel
{
    @synchronized(_autoSkinArray)
    {
        if ([_autoSkinArray containsObject:autoSkinModel])
        {
            [_autoSkinArray removeObject:autoSkinModel];
        }
    }
}

+ (void)removeAutoSkinModel:(SUIAutoSkinViewModel *)autoSkinModel;
{
    [[SUIAutoSkinManager sharedInstance] instanceRemoveAutoSkinModel:autoSkinModel];
}

#pragma mark - Skin Path Methods

- (NSString *)instanceCurrentSkinPath
{
    return _currentSkinFolderPath;
}

+ (NSString *)currentSkinPath
{
    return [[SUIAutoSkinManager sharedInstance] instanceCurrentSkinPath];
}

- (BOOL)instanceChangeSkinPath:(NSString *)skinFolderPath
{
    if (_changingAllSkinThread && [_changingAllSkinThread isExecuting])
    {
        return NO;
    }
    else
    {
        _currentSkinFolderPath = skinFolderPath;
        @synchronized(_autoSkinArray)
        {
            if (_changingAllSkinThread) _changingAllSkinThread = nil;
            _changingAllSkinThread = [[NSThread alloc] initWithTarget:self selector:@selector(refreshAllSkinModel) object:nil];
            [_changingAllSkinThread start];
        }
        return YES;
    }
    return NO;
}

+ (BOOL)changeSkinPath:(NSString *)skinFolderPath
{
    return [[SUIAutoSkinManager sharedInstance] instanceChangeSkinPath:skinFolderPath];
}

#pragma mark - Life Cycle

- (void)instanceSetDelegate:(id<SUIAutoSkinDelegate>)delegate
{
    _delegate = delegate;
}

+ (void)setDelegate:(id<SUIAutoSkinDelegate>)delegate
{
    [[SUIAutoSkinManager sharedInstance] instanceSetDelegate:delegate];
}

+ (id)sharedInstance
{
    static SUIAutoSkinManager *keeper;
    if (!keeper)
    {
        keeper = [[SUIAutoSkinManager alloc] init];
    }
    return keeper;
}

- (id)init
{
    self = [super init];
    if (self) {
        _autoSkinArray = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
