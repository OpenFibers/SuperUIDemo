//
//  SUICell.m
//  SuperUIDemo
//
//  Created by OpenThread on 11/3/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import "SUICell.h"

@implementation SUICell
{
    __unsafe_unretained SUISectionModel *_superSectionModel;
    __unsafe_unretained SUITableView *_superTableView;
}

- (SUISectionModel *)superSectionModel
{
    NSIndexPath *indexPath = [self.superTableView indexPathForCell:self];
    if (indexPath)
    {
        SUISectionModel *sectionModel = [self.superTableView.sections objectAtIndex:indexPath.section];
        return sectionModel;
    }
    return nil;
}

- (SUITableView *)superTableView
{
    return _superTableView;
}

//设置superTableView,仅在初始化完成后在SUITableView中用objc_msgSend调用
- (void)setSUISuperTableView:(SUITableView *)tableView
{
    _superTableView = tableView;
}

- (SUICellModel *)model
{
    NSIndexPath *indexPath = [self.superTableView indexPathForCell:self];
    if (indexPath)
    {
        SUISectionModel *sectionModel = [self.superTableView.sections objectAtIndex:indexPath.section];
        SUICellModel *cellModel = [sectionModel.cells objectAtIndex:indexPath.row];
        return cellModel;
    }
    return nil;
}

- (void)setModel:(SUICellModel *)model
{
    self.textLabel.text = model.textLabelString;
    self.detailTextLabel.text = model.detailLabelString;
    self.imageView.image = model.image;
    self.accessoryType = model.accessoryType;
    _superSectionModel = model.superSectionModel;
    _superTableView = model.superTableView;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.textLabel.text = @"";
    self.detailTextLabel.text = @"";
    self.imageView.image = nil;
    self.accessoryType = UITableViewCellAccessoryNone;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initConstantSubViews];
    }
    return self;
}

- (void)initConstantSubViews
{
    //Empty Method
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
