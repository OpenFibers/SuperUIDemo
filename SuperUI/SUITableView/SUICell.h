//
//  SUICell.h
//  SuperUIDemo
//
//  Created by OpenThread on 11/3/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUICellModel.h"
#import "SUISectionModel.h"
#import "SUITableView.h"

@interface SUICell : UITableViewCell

/*
 The model of this cell.
 Change this value will refresh the content of this cell immediately.
 */
@property (nonatomic,assign) SUICellModel *model;

/*
 The super section model of this cell.
 Readonly.
 */
@property (nonatomic,readonly,assign) SUISectionModel *superSectionModel;

/*
 The super table view of this cell.
 Readonly.
 */
@property (nonatomic,readonly,assign) SUITableView *superTableView;


/*
 Init cell with style and reuse identifier.
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

/*
 Override this method to init subviews which should be loaded only once.
 */
- (void)initConstantSubViews;

@end
