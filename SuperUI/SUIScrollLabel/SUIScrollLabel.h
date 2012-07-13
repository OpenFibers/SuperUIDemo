//
//  SUIScrollLabel.h
//  RadioTaste
//
//  Created by OpenThread on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SUIScrollLabel : UIView
{
    UIView *_scrollView;
    UILabel *_label;
    UILabel *_mirrorLabel;
    NSTimer *_scrollTimer;
    
    NSTimeInterval _headStayTime;//首部停留时间
    CGFloat _labelBlank;//两边label相隔宽度
    float _scrollPixelsPerSecond;//每秒滚动像素
}

@property (nonatomic,assign) NSTimeInterval headStayTime;
@property (nonatomic,assign) CGFloat labelBlank;
@property (nonatomic,assign) float scrollPixelsPerSecond;

@property (nonatomic) NSString *text;
@property (nonatomic) UIColor *textColor;
@property (nonatomic) UIFont *font;
@property (nonatomic) UITextAlignment textAlignment;
@property (nonatomic) UIColor *shadowColor;
@property (nonatomic) CGSize shadowOffset;

@end
