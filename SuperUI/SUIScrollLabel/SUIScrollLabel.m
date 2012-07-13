//
//  SUIScrollLabel.m
//  RadioTaste
//
//  Created by OpenThread on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SUIScrollLabel.h"

@implementation SUIScrollLabel

- (void)setFrame:(CGRect)frame
{
    _scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    [super setFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _headStayTime = 2;
        _labelBlank = 40.0f;
        _scrollPixelsPerSecond = 30;
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _label.backgroundColor = [UIColor clearColor];
        _label.numberOfLines = 1;
        _label.textAlignment = UITextAlignmentCenter;
        
        _mirrorLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width + _labelBlank, 0, frame.size.width, frame.size.height)];
        _mirrorLabel.backgroundColor = [UIColor clearColor];
        _mirrorLabel.numberOfLines = 1;
        _mirrorLabel.textAlignment = UITextAlignmentCenter;
        
        _scrollView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _scrollView.clipsToBounds = YES;
        
        [_scrollView addSubview:_label];
        [_scrollView addSubview:_mirrorLabel];
        [self addSubview:_scrollView];
        
    }
    return self;
}

- (void)beginScroll
{
    CGRect labelRect = _label.frame;
    CGRect mirrorLabelRect = _mirrorLabel.frame;
    labelRect.origin.x = 0;
    mirrorLabelRect.origin.x = _label.frame.size.width + _labelBlank;
    _label.frame = labelRect;
    _mirrorLabel.frame = mirrorLabelRect;
    
    [UIView beginAnimations:@"scrollAnimation" context:nil];
    [UIView setAnimationDuration:(_label.frame.size.width + _labelBlank)/_scrollPixelsPerSecond];
    [UIView setAnimationDelay:_headStayTime];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    labelRect = _label.frame;
    mirrorLabelRect = _mirrorLabel.frame;
    labelRect.origin.x -= _label.frame.size.width + _labelBlank;
    mirrorLabelRect.origin.x -= _label.frame.size.width + _labelBlank;
    _label.frame = labelRect;
    _mirrorLabel.frame = mirrorLabelRect;
    [UIView commitAnimations];
}

- (void)scheduleScrollTimer
{
    if (_scrollTimer)
    {
        [_scrollTimer invalidate];
    }
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:
                      _headStayTime + (_label.frame.size.width + _labelBlank)/_scrollPixelsPerSecond
                                                      target:self 
                                                    selector:@selector(beginScroll)
                                                    userInfo:nil 
                                                     repeats:YES];
    _scrollTimer = timer;
    [timer fire];
}

- (void)dealloc
{
    if (_scrollTimer)
    {
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
}

#pragma mark - Properties

- (NSString *)text
{
    return _label.text;
}

- (void)setText:(NSString *)text
{
    NSString *textToSet = text;
    if (!textToSet) textToSet = @"";
    _label.text = textToSet;
    _mirrorLabel.text = textToSet;
    CGSize labelSize = [textToSet sizeWithFont:_label.font];
    if (labelSize.width > self.frame.size.width)
    {
        _label.frame = CGRectMake(0, 0, labelSize.width, self.frame.size.height);
        _mirrorLabel.frame = CGRectMake(labelSize.width + _labelBlank, 0, labelSize.width, self.frame.size.height);
        [self scheduleScrollTimer];
    }
    else
    {
        [UIView beginAnimations:@"staticAnimation" context:nil];
        [UIView setAnimationDuration:0.0f];
        _label.frame = CGRectMake(round((self.frame.size.width - labelSize.width)/2), 0, labelSize.width, self.frame.size.height);
        [UIView commitAnimations];
        _mirrorLabel.frame = CGRectZero;
        [_scrollTimer invalidate];
        _scrollTimer = nil;
    }
}

@synthesize headStayTime = _headStayTime;
@synthesize labelBlank = _labelBlank;
@synthesize scrollPixelsPerSecond = _scrollPixelsPerSecond;

- (void)setScrollPixelsPerSecond:(float)scrollPixelsPerSecond
{
    if (scrollPixelsPerSecond != 0)
    {
        _scrollPixelsPerSecond = scrollPixelsPerSecond;
    }
    else
    {
        NSAssert(0, @"scrollPixelsPerSecond coundn't be 0");
    }
}

- (UIColor *)textColor
{
    return _label.textColor;
}

- (void)setTextColor:(UIColor *)textColor
{
    _label.textColor = textColor;
    _mirrorLabel.textColor = textColor;
}

- (UIFont *)font
{
    return _label.font;
}

- (void)setFont:(UIFont *)font
{
    _label.font = font;
    _mirrorLabel.font = font;
}

- (UITextAlignment)textAlignment
{
    return _label.textAlignment;
}

- (void)setTextAlignment:(UITextAlignment)textAlignment
{
    _label.textAlignment = textAlignment;
    _mirrorLabel.textAlignment = textAlignment;
}

- (UIColor *)shadowColor
{
    return _label.shadowColor;
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    _label.shadowColor = shadowColor;
    _mirrorLabel.shadowColor = shadowColor;
}

- (CGSize)shadowOffset
{
    return _label.shadowOffset;
}

- (void)setShadowOffset:(CGSize)shadowOffset
{
    _label.shadowOffset = shadowOffset;
    _mirrorLabel.shadowOffset = shadowOffset;
}

@end
