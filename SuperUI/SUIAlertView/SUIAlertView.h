//
//  SUIAlertView.h
//  OfficeReader
//
//  Created by openthread on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SUIAlertView : UIView


+ (UIAlertView *)showAlertWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle;

+ (UIAlertView *)showAlertWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle tag:(NSUInteger)tag;

+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                           delegate:(id <UIAlertViewDelegate>)delegate
                                tag:(NSUInteger)tag
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                 confirmButtonTitle:(NSString *)confirmButtonTitle;

+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                           delegate:(id <UIAlertViewDelegate>)delegate
                                tag:(NSUInteger)tag
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                 confirmButtonTitle:(NSString *)confirmButtonTitle;

@end
