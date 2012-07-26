//
//  ISHorizontalMoveTableView.m
//  issue
//
//  Created by OpenThread on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UITableView+HorizontalMove.h"
#import "SUITableViewCellPanGestureRecognizer.h"
#import <objc/runtime.h>

#define kSUIHorizontalMoveTableGesturePropertyString            @"kSUIHorizontalMoveTableViewPanGesture"
#define kSUIHorizontalMoveTableTouchedCellPropertyString        @"kSUIHorizontalMoveTableViewTouchedCell"
#define kSUIHorizontalMoveTableStartPointXPropertyString        @"kSUIHorizontalMoveTableViewStartPointX"
#define kSUIHorizontalMoveTableStartPointYPropertyString        @"kSUIHorizontalMoveTableViewStartPointY"

#define kSUIHorizontalMoveTableDelegatePropertyString           @"kSUIHorizontalMoveTableViewDelegate"


#pragma mark - Assist Properties

@interface UITableView(HorizontalMoveHelper)

@property (nonatomic,retain) SUITableViewCellPanGestureRecognizer *horizontalPanGesture;
@property (nonatomic,retain) UITableViewCell *touchedCellForHorizontalMove;
@property (nonatomic,retain) NSNumber *startTouchPointXForHorizontalMove;
@property (nonatomic,retain) NSNumber *startTouchPointYForHorizontalMove;

@end

@implementation UITableView(HorizontalMoveHelper)

@dynamic horizontalPanGesture;

- (SUITableViewCellPanGestureRecognizer *)horizontalPanGesture
{
    return objc_getAssociatedObject(self, kSUIHorizontalMoveTableGesturePropertyString);
}

- (void)setHorizontalPanGesture:(SUITableViewCellPanGestureRecognizer *)horizontalPanGesture
{
    objc_setAssociatedObject(self, 
                             kSUIHorizontalMoveTableGesturePropertyString, 
                             horizontalPanGesture,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic touchedCellForHorizontalMove;

- (UITableViewCell *)touchedCell
{
    return objc_getAssociatedObject(self, kSUIHorizontalMoveTableTouchedCellPropertyString);
}

- (void)setTouchedCell:(UITableViewCell *)touchedCell
{
    objc_setAssociatedObject(self, 
                             kSUIHorizontalMoveTableTouchedCellPropertyString,
                             touchedCell, 
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic startTouchPointXForHorizontalMove;

- (NSNumber *)startTouchPointX
{
    return objc_getAssociatedObject(self, kSUIHorizontalMoveTableStartPointXPropertyString);
}

- (void)setStartTouchPointX:(NSNumber *)startTouchPointX
{
    objc_setAssociatedObject(self,
                             kSUIHorizontalMoveTableStartPointXPropertyString, 
                             startTouchPointX,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic startTouchPointYForHorizontalMove;

- (NSNumber *)startTouchPointY
{
    return objc_getAssociatedObject(self, kSUIHorizontalMoveTableStartPointYPropertyString);
}

- (void)setStartTouchPointY:(NSNumber *)startTouchPointY
{
    objc_setAssociatedObject(self,
                             kSUIHorizontalMoveTableStartPointYPropertyString, 
                             startTouchPointY,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#pragma mark - Delegate CallBack

@interface UITableView (HorizontalMoveDelegateCallBack)<SUITableViewCellPanGestureRecognizerDelegate>
@end

@implementation UITableView (HorizontalMoveDelegateCallBack)

- (void)touchesBeganInPanGestureRecognizer:(SUITableViewCellPanGestureRecognizer *)panGestureRecognizer
{
    if ([self.horizontalMoveDelegate respondsToSelector:@selector(touchesBeganInTableView:)])
    {
        [self.horizontalMoveDelegate touchesBeganInTableView:self];
    }
}

@end

#pragma mark - Move Mothods

@implementation UITableView(HorizontalMove)

@dynamic horizontalMoveDelegate;

- (id<SUIHorizontalMoveTableViewDelegate>)horizontalMoveDelegate
{
    return objc_getAssociatedObject(self, kSUIHorizontalMoveTableDelegatePropertyString);
}

- (void)setHorizontalMoveDelegate:(id<SUIHorizontalMoveTableViewDelegate>)horizontalMoveDelegate
{
    objc_setAssociatedObject(self, kSUIHorizontalMoveTableDelegatePropertyString, horizontalMoveDelegate, OBJC_ASSOCIATION_ASSIGN);
    SUITableViewCellPanGestureRecognizer *rec = [[SUITableViewCellPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHorizontalDrag:)];
    rec.panGestureDelegate = self;
    self.horizontalPanGesture = rec;
    [self addGestureRecognizer:self.horizontalPanGesture];
}

-(void)handleHorizontalDrag:(UIGestureRecognizer *)gesture
{   
    UIGestureRecognizerState state = gesture.state;
    
    if (!self.touchedCell)
    {
        NSIndexPath *indexPathAtHitPoint = [self indexPathForRowAtPoint:[gesture locationInView:self]];
        id cell = [self cellForRowAtIndexPath:indexPathAtHitPoint];
        self.touchedCell = cell;
        CGPoint startPoint = [gesture locationInView:self.touchedCell];
        self.startTouchPointX = [NSNumber numberWithFloat:startPoint.x];
        self.startTouchPointY = [NSNumber numberWithFloat:startPoint.y];
    }
    
    if ( state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged )
    {
        CGPoint nowTouchPoint = [gesture locationInView:self.touchedCell];
        CGFloat horizontalMoved = nowTouchPoint.x - self.startTouchPointX.floatValue;
        if (self.horizontalMoveDelegate && [self.horizontalMoveDelegate respondsToSelector:@selector(horizontalMoveTableView:movedHorizontal:)])
        {
            [self.horizontalMoveDelegate horizontalMoveTableView:self movedHorizontal:horizontalMoved];
        }
    }
    else if ( state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled )
    {
        self.touchedCell = nil;
        if (self.horizontalMoveDelegate && [self.horizontalMoveDelegate respondsToSelector:@selector(horizontalMoveTableViewEndedMove:)])
        {
            [self.horizontalMoveDelegate horizontalMoveTableViewEndedMove:self];
        }
    }
}

@end
