//
//  SUIRuntime.h
//  Pomodoro
//
//  Created by OpenThread on 12/12/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//


//Sends a message with a simple return value to an instance of a class.
id objc_msgSend(id theReceiver, SEL theSelector, ...);

//Returns the name of the method specified by a given selector.
const char* sel_getName(SEL aSelector);

//Returns count of arguments of a given selector.
int sel_getArgumentCount(SEL aSelector);