//
//  SUIAlertView.m
//  OfficeReader
//
//  Created by openthread on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SUIAlertView.h"

@implementation SUIAlertView

+ (UIAlertView *)showAlertWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle

{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:nil 
                                                       delegate:nil 
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:nil, nil];
    [alertView show];
    return alertView;
}

+ (UIAlertView *)showAlertWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle tag:(NSUInteger)tag
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:nil 
                                                       delegate:nil 
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:nil, nil];
    alertView.tag = tag;
    [alertView show];
    return alertView;
}

+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                           delegate:(id <UIAlertViewDelegate>)delegate
                                tag:(NSUInteger)tag
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                 confirmButtonTitle:(NSString *)confirmButtonTitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:nil 
                                                       delegate:delegate 
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:confirmButtonTitle, nil];
    alertView.tag = tag;
    [alertView show];
    return alertView;
}

+ (UIAlertView *)showAlertWithTitle:(NSString *)title
                            message:(NSString *)message
                           delegate:(id <UIAlertViewDelegate>)delegate
                                tag:(NSUInteger)tag
                  cancelButtonTitle:(NSString *)cancelButtonTitle
                 confirmButtonTitle:(NSString *)confirmButtonTitle
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message 
                                                       delegate:delegate 
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:confirmButtonTitle, nil];
    alertView.tag = tag;
    [alertView show];
    return alertView;
}


@end
