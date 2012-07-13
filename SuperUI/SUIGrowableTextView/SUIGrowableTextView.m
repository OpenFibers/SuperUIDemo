//
//  SUIGrowableTextView.m
//  snstaoban
//
//  Created by OpenThread on 12/14/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import "SUIGrowableTextView.h"

@implementation SUIGrowableTextView

@synthesize delegate = _delegate;

- (NSTimeInterval)animationDuration
{
    return _animationDuration;
}

- (void)setAnimationDuration:(NSTimeInterval)animationDuration
{
    _animationDuration = animationDuration;
    _innerTextView.animationDuration = animationDuration;
}

- (NSTimeInterval)animationDelay
{
    return _animationDelay;
}

- (void)setAnimationDelay:(NSTimeInterval)animationDelay
{
    _animationDelay = animationDelay;
    _innerTextView.animationDelay = animationDelay;
}

- (BOOL)hasText
{
    return [_innerTextView hasText];
}

- (NSString *)text
{
    return _innerTextView.text;
}

- (void)setText:(NSString *)text
{
    _innerTextView.text = text;
}

- (UIFont *)font
{
    return _innerTextView.font;
}

- (void)setFont:(UIFont *)font
{
    _innerTextView.font = font;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)setHeight:(CGFloat)newHeight
{
    CGRect origionSelfFrame = self.frame;
    CGRect newSelfFrame = CGRectMake(origionSelfFrame.origin.x, origionSelfFrame.origin.y, origionSelfFrame.size.width, newHeight);
    CGRect originScrollViewFrame = _scrollView.frame;
    CGRect newScrollFrame = CGRectMake(originScrollViewFrame.origin.x, originScrollViewFrame.origin.y, originScrollViewFrame.size.width, newHeight);
    _scrollView.contentSize = newScrollFrame.size;
    [UIView beginAnimations:@"NewFrameOfSelf" context:nil];
    [UIView setAnimationDuration:_animationDuration];
    [UIView setAnimationDelay:_animationDelay];
    [UIView setAnimationDelegate:self];
    self.frame = newSelfFrame;
    _scrollView.frame = newScrollFrame;
    [UIView commitAnimations];
}

- (id)initWithFrame:(CGRect)frame minHeight:(CGFloat)minHeight maxHeight:(CGFloat)maxHeight
{
    self = [self initWithFrame:frame minHeight:minHeight maxHeight:maxHeight edgeInsets:UIEdgeInsetsZero];
    if (self) {
        //init
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame minHeight:(CGFloat)minHeight maxHeight:(CGFloat)maxHeight edgeInsets:(UIEdgeInsets)edgeInsets
{
    self = [super initWithFrame:frame];
    if (self) {
        _minHeight = minHeight;
        _maxHeight = maxHeight;
        _originSize = frame.size;
        
        _textViewInsets = UIEdgeInsetsMake(12 - edgeInsets.top, 10 - edgeInsets.left, 12 - edgeInsets.bottom, 10 - edgeInsets.right);
        CGRect scrollViewFrame= CGRectMake(0, 0, frame.size.width, frame.size.height);
        CGRect innerTextViewFrame = CGRectMake(- _textViewInsets.left, -_textViewInsets.top, frame.size.width + _textViewInsets.left + _textViewInsets.right, frame.size.height + _textViewInsets.top + _textViewInsets.bottom);
        
        _innerTextView = [[SUIInnerTextView alloc] initWithFrame:innerTextViewFrame];
        _innerTextView.backgroundColor = [UIColor clearColor];
        _innerTextView.scrollEnabled = NO;
        _innerTextView.delegate = self;
        
        _scrollView = [[SUIGrowableScrollView alloc] initWithFrame:scrollViewFrame];
        _scrollView.scrollEnabled = NO;
        _scrollView.contentSize = scrollViewFrame.size;
        [_scrollView addSubview:_innerTextView];
        _scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:_scrollView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [self initWithFrame:frame minHeight:0 maxHeight:(NSUInteger)-1];
    if (self) {
        //init here
    }
    return self;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (_delegate && [_delegate respondsToSelector:@selector(growableTextViewDidChanged:)])
    {
        [_delegate growableTextViewDidChanged:self];
    }
    
    CGSize newTextViewSize = _innerTextView.contentSize;
    CGSize newScrollViewSize = CGSizeMake(newTextViewSize.width - _textViewInsets.left - _textViewInsets.right, newTextViewSize.height - _textViewInsets.top - _textViewInsets.bottom);

    NSString *textNow = textView.text;
    if ([textNow isEqualToString:@""]) {
        newScrollViewSize = _originSize;
    }
    _innerTextView.frame = CGRectMake(-_textViewInsets.left, -_textViewInsets.bottom, newTextViewSize.width, newTextViewSize.height);
    CGFloat newScrollViewHeight = newScrollViewSize.height;
    if (newScrollViewHeight < _minHeight)
    {
        newScrollViewHeight = _lastHeight;
    }
    if (newScrollViewHeight > _maxHeight)
    {
        newScrollViewHeight = _lastHeight;
    }
    _lastHeight = newScrollViewHeight;
    if ((_lastScrollViewSize.height != newScrollViewSize.height) || (_lastScrollViewSize.width != newScrollViewSize.width))//大小有变化时
    {
        if (_delegate && [_delegate respondsToSelector:@selector(growableTextView:willChangeToSize:)])
        {
            [_delegate growableTextView:self willChangeToSize:CGSizeMake(self.frame.size.width, newScrollViewHeight)];
        }
        [self setHeight:newScrollViewHeight];
    }
    _lastScrollViewSize = newScrollViewSize;
}

- (void)animationDidStop: (NSString *) animationID finished:(NSNumber *)finished context:(void *)context
{    
    if([animationID isEqualToString:@"NewFrameOfSelf"])
    {
        _scrollView.contentSize = CGSizeMake(_innerTextView.frame.size.width - _textViewInsets.left - _textViewInsets.right, _innerTextView.frame.size.height - _textViewInsets.top - _textViewInsets.bottom);
        CGFloat newContentOffsetY = 0;
        if ([_innerTextView hasText])//如果有文字，offset正常算，否则按0算，为了解决4.3中会漂移的问题 
        {
            newContentOffsetY = _scrollView.contentSize.height - _scrollView.frame.size.height;
        }
        if (newContentOffsetY == 0) 
        {
            _scrollView.scrollEnabled = NO;
        }
        else
        {
            _scrollView.scrollEnabled = YES;
        }
        if (_scrollView.contentSize.height > _maxHeight) {
            _scrollView.suiScrollEnable = YES;
        }
        else
        {
            _scrollView.suiScrollEnable = NO;
        }
        CGPoint newContentOffset = CGPointMake(0, newContentOffsetY);
        [_scrollView setGrowableContentOffset:newContentOffset];
    }
}

#pragma mark - TextViewDelegate Section

- (BOOL)becomeFirstResponder
{
    if (_innerTextView) {
        return [_innerTextView becomeFirstResponder];
    }
    return [super becomeFirstResponder]; 
}

- (BOOL)resignFirstResponder
{
    if (_innerTextView) {
        return [_innerTextView resignFirstResponder];
    }
    return [super resignFirstResponder];
}

- (BOOL)textViewShouldBeginEditing:(UITableView *)textView
{
    if (_delegate && [_delegate respondsToSelector:@selector(textViewShouldBeginEditing:)])
    {
        return [_delegate textViewShouldBeginEditing:self];
    }
    return YES;
}

- (void)reset
{
    _innerTextView.text = nil;
    [self textViewDidChange:_innerTextView];
}

@end
