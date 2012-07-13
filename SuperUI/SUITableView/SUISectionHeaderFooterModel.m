//
//  SUISectionHeaderFooterModel.m
//  SuperUIDemo
//
//  Created by OpenThread on 10/31/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import "SUISectionHeaderFooterModel.h"
#import "SUITableView.h"

@implementation SUISectionHeaderFooterModel

#pragma mark - Super

@synthesize superSectionModel = _superSectionModel;

- (id)superTableView
{
    SUISectionModel *sectionModel = self.superSectionModel;
    SUITableView *suiTableView = sectionModel.superTableView;
    return suiTableView;
}

- (NSUInteger)indexInSuperTableView
{
    SUISectionModel *sectionModel = self.superSectionModel;
    NSUInteger indexOfSuperTableView = sectionModel.indexInSuperTable;
    return indexOfSuperTableView;
}

#pragma mark - Height

- (CGFloat)height
{
    return _height;
}

- (void)setHeight:(CGFloat)height
{
    _height = height;
    [self reloadData];
}

- (void)setHeight:(CGFloat)height withRowAnimation:(UITableViewRowAnimation)animation
{
    _height = height;
    [self reloadDataWithRowAnimation:animation];
}

#pragma mark - Content

- (NSString *)textString
{
    return _textString;
}

- (void)setTextString:(NSString *)string
{
    _view = nil;
    _textString = string;
    [self reloadData];
}

- (void)setString:(NSString *)string withRowAnimation:(UITableViewRowAnimation)animation
{
    _view = nil;
    _textString = string;
    [self reloadDataWithRowAnimation:animation];
}

- (UIView *)view
{
    return _view;
}

- (void)setContentOfView:(UIView *)newView
{
    _height = newView.frame.size.height + newView.frame.origin.y;
    _textString = nil;
    if (!_view)
    {
        _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, newView.frame.size.width + newView.frame.origin.x, _height)];
    }
    else
    {
        [[[_view subviews] objectAtIndex:0] removeFromSuperview];
    }
    [_view addSubview:newView];

}

- (void)setView:(UIView *)newView
{
    [self setContentOfView:newView];
    [self reloadData];
}

- (void)setView:(UIView *)newView withRowAnimation:(UITableViewRowAnimation)animation
{
    [self setContentOfView:newView];
    [self reloadDataWithRowAnimation:animation];
}

#pragma mark - Reload

- (void)reloadData
{
    SUITableView *tableView = self.superTableView;
    [tableView reloadData];
}

- (void)reloadDataWithRowAnimation:(UITableViewRowAnimation)animation
{
    SUITableView *tableView = self.superTableView;
    int indexOfHeader = self.indexInSuperTableView;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexOfHeader];
    [tableView reloadSections:indexSet withRowAnimation:animation];
}

#pragma mark - Init

- (id)initWithSuperSectionModel:(SUISectionModel *)superSectionModel
{
    self = [super init];
    if (self) {
        //Init code here.
        _superSectionModel = superSectionModel;
    }
    return self;
}

@end