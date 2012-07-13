//
//  SUIGrowableScrollView.h
//  snstaoban
//
//  Created by OpenThread on 12/19/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SUIGrowableScrollView : UIScrollView
{
    BOOL _suiScrollEnable;
}

@property (nonatomic,assign) BOOL suiScrollEnable;

- (void)setGrowableContentOffset:(CGPoint)contentOffset;

@end
