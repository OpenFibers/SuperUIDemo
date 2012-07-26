//
//  ISTableViewCellPanGestureRecognizer.h
//  issue
//
//  Created by OpenThread on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIGestureRecognizerSubclass.h>

@class SUITableViewCellPanGestureRecognizer;

@protocol SUITableViewCellPanGestureRecognizerDelegate <NSObject>

@optional
- (void)touchesBeganInPanGestureRecognizer:(SUITableViewCellPanGestureRecognizer *)panGestureRecognizer;

@end

@interface SUITableViewCellPanGestureRecognizer : UIGestureRecognizer

- (void)reset;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@property (nonatomic,assign) id<SUITableViewCellPanGestureRecognizerDelegate> panGestureDelegate;

@end
