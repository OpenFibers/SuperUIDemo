//
//  ISTableViewCellPanGestureRecognizer.m
//  issue
//
//  Created by OpenThread on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SUITableViewCellPanGestureRecognizer.h"

//此类用于UIGestureRecognizerState重新分配

@implementation SUITableViewCellPanGestureRecognizer
{
    CGPoint startTouchPoint;
    CGPoint currentTouchPoint;
    BOOL isPanningHorizontally;
}

@synthesize panGestureDelegate = _panGestureDelegate;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.panGestureDelegate && [self.panGestureDelegate respondsToSelector:@selector(touchesBeganInPanGestureRecognizer:)])
    {
        [self.panGestureDelegate touchesBeganInPanGestureRecognizer:self];
    }
    [super touchesBegan:touches withEvent:event];
    startTouchPoint = [[touches anyObject] locationInView:nil];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
    const static CGFloat sensitive = 10.0f;//灵敏度,水平移动首先超过此值则判定为水平移动,竖直移动首先超过此值则判定为竖直移动
    [super touchesMoved:touches withEvent:event];
    currentTouchPoint = [[touches anyObject] locationInView:nil];
    
    if ( !isPanningHorizontally )
    {
        float horizontalMoved = fabsf(currentTouchPoint.x - startTouchPoint.x);
        float verticalMoved = fabsf(currentTouchPoint.y - startTouchPoint.y);
        if ( horizontalMoved > sensitive )//触发条件
        {
            self.state = UIGestureRecognizerStateBegan;
            isPanningHorizontally = YES;
            [self.view touchesCancelled:touches withEvent:event];
        }
        else if (verticalMoved > sensitive)
        {
            self.state = UIGestureRecognizerStateCancelled;
            [self.view touchesCancelled:touches withEvent:event];
        }
        else
        {
            return;
        }
    }
    else
    {
        self.state = UIGestureRecognizerStateChanged;
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    self.state = UIGestureRecognizerStateCancelled;
    [self.view touchesCancelled:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    self.state = UIGestureRecognizerStateCancelled;
}

-(void)reset
{
    [super reset];
    startTouchPoint = CGPointZero;
    currentTouchPoint = CGPointZero;
    isPanningHorizontally = NO;
}

@end
