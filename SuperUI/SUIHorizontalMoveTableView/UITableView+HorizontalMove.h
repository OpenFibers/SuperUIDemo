//
//  ISHorizontalMoveTableView.h
//  issue
//
//  Created by OpenThread on 6/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SUIHorizontalMoveTableViewDelegate <NSObject>

- (void)touchesBeganInTableView:(UITableView *)horizontalMoveTableView;

- (void)horizontalMoveTableView:(UITableView *)horizontalMoveTableView movedHorizontal:(CGFloat)horizontalMoved;

- (void)horizontalMoveTableViewEndedMove:(UITableView *)horizontalMoveTableView;

@end

@interface UITableView(HorizontalMove)

@property (nonatomic,assign) id<SUIHorizontalMoveTableViewDelegate> horizontalMoveDelegate;

@end
