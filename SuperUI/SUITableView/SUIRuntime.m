//
//  SUIRuntime.m
//  Pomodoro
//
//  Created by OpenThread on 12/12/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import "SUIRuntime.h"

int sel_getArgumentCount(SEL aSelector)
{
    const char *nameOfSelector = sel_getName(aSelector);
    int i = 0;
    while (*nameOfSelector != '\0') {
        if (*nameOfSelector == ':') {
            i++;
        }
        nameOfSelector++;
    }
    return i;
}