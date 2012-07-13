//
//  SUIGrowableTextView.h
//  snstaoban
//
//  Created by OpenThread on 12/14/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUIInnerTextView.h"
#import "SUIGrowableScrollView.h"
@class SUIGrowableTextView;

@protocol SUIGrowableTextViewDelegate <NSObject>

@optional

/*
 Asks the delegate if editing should begin in the specified text view.
 */
- (BOOL)textViewShouldBeginEditing:(SUIGrowableTextView *)textView;

/*
 Callback when growable text view did changed.
 */
- (void)growableTextViewDidChanged:(SUIGrowableTextView *)growableTextView;

/*
 Callback when growable text view will change to a new size.
 */
- (void)growableTextView:(SUIGrowableTextView *)growableTextView willChangeToSize:(CGSize)newSize;

@end

@interface SUIGrowableTextView : UIView <UITextViewDelegate>
{
    SUIInnerTextView *_innerTextView;
    SUIGrowableScrollView *_scrollView;
    CGFloat _minHeight;
    CGFloat _maxHeight;
    CGSize _lastScrollViewSize;//self.contentSize上次的值
    CGFloat _lastHeight;//self.contentSize.height上次的值
    CGSize _originSize;//创建时frame的size。用于没有文字时设置frame。
    UIEdgeInsets _textViewInsets;
    
    __unsafe_unretained id<SUIGrowableTextViewDelegate> _delegate;
    NSTimeInterval _animationDuration; 
    NSTimeInterval _animationDelay;
}

/*
 Returns a Boolean value indicating whether the text view currently contains any text.
 */
- (BOOL)hasText;

/*
 Text in inner text view.
 */
@property (nonatomic,assign) NSString *text;

/*
 Font of inner text view.
 */
@property (nonatomic,assign) UIFont *font;

/*
 When this control's size changed,it will notify the delegate the new size it has.
 */
@property (nonatomic,assign) id<SUIGrowableTextViewDelegate> delegate;

/*
 The animation time when this control change its size.
 */
@property (nonatomic,assign) NSTimeInterval animationDuration;

/*
 The animation delay time when this control change its size.
 */
@property (nonatomic,assign) NSTimeInterval animationDelay;

/*
 Init with a frame and min height and max height.Edge insets will be UIEdgeInsetsZero.
 */
- (id)initWithFrame:(CGRect)frame minHeight:(CGFloat)minHeight maxHeight:(CGFloat)maxHeight;

/*
 Init with a frame, min height, max height and a UIEdgeInsets.
 */
- (id)initWithFrame:(CGRect)frame minHeight:(CGFloat)minHeight maxHeight:(CGFloat)maxHeight edgeInsets:(UIEdgeInsets)edgeInsets;

/*
 Empty this view, and the frame will be the origin frame.
 */
- (void)reset;

@end
