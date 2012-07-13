//
//  SUITableViewCell.m
//  SuperUIDemo
//
//  Created by OpenThread on 10/31/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import "SUICellModel.h"
#import "SUITableView.h"
#import "SUICell.h"
#import "OTRuntime.h"
#import "SUITableView.h"

@implementation SUICellModel

#pragma mark - Pointer of displayed cell

- (SUICell *)cell
{
    NSUInteger section = [self.superTableView indexOfSectionModel:self.superSectionModel];
    NSUInteger row = [self.superSectionModel indexOfCellModel:self];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    SUICell *cell = (SUICell *)[self.superTableView cellForRowAtIndexPath:indexPath];
    return cell;
}

#pragma mark - Layout

//Style is an readonly property.
- (UITableViewCellStyle)style
{
    return _style;
}

- (CGFloat)height
{
    return _height;
}

- (void)setHeight:(CGFloat)height
{
    if (_height != height) {
        _hasLayoutChanged = YES;
        _height = height;
        [self reloadData];
    }
}

- (void)setHeight:(CGFloat)height withRowAnimation:(UITableViewRowAnimation)animation
{
    if (_height != height) {
        _hasLayoutChanged = YES;
        _height = height;
        [self reloadDataWithRowAnimation:animation];
    }
}

- (UITableViewCellAccessoryType)accessoryType
{
    return _accessoryType;
}

- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType
{
    if (_accessoryType != accessoryType) {
        _hasLayoutChanged = YES;
        _accessoryType = accessoryType;
        if (self.cell) {
            self.cell.accessoryType = accessoryType;
        }
    }
}

#pragma mark - Data model

- (NSString*)textLabelString
{
    return _textLabelString;
}

- (void)setTextLabelString:(NSString *)textLabelString
{
    if (_textLabelString != textLabelString) {
        _textLabelString = textLabelString;
        [self reloadData];
    }
}

- (NSString *)detailLabelString
{
    return _detailLabelString;
}

- (void)setDetailLabelString:(NSString *)detailLabelString
{
    if (_detailLabelString != detailLabelString) {
        _detailLabelString = detailLabelString;
        [self reloadData];
    }
}

- (UIImage *)image
{
    return _image;
}

- (void)setImage:(UIImage *)image
{
    if (_image != image) {
        _image = image;
        [self reloadData];
    }
}

#pragma mark - Super model

@synthesize superSectionModel = _superSectionModel;

- (id)superTableView
{
    SUISectionModel *sectionModel = self.superSectionModel;
    SUITableView *suiTableView = sectionModel.superTableView;
    return suiTableView;
}

- (NSUInteger)indexInSuperSection
{
    SUISectionModel *sectionModel = self.superSectionModel;
    NSUInteger indexInSuperSection = [sectionModel indexOfCellModel:self];
    return indexInSuperSection;
}

- (NSIndexPath *)indexPathInSuperTableView
{
    SUISectionModel *superSectionModel = self.superSectionModel;
    int rowIndex = self.indexInSuperSection;
    int sectionIndex = superSectionModel.indexInSuperTable;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
    return indexPath;
}

#pragma mark - Touched inside event

@synthesize target = _target;
@synthesize tappedSelector = _tappedSelector;

- (void)addSelectedEventTarget:(id)target selector:(SEL)selector
{
    NSAssert(sel_getArgumentsCount(selector) <= 1, @"Selector arguments count up to 1");
    _target = target;
    _tappedSelector = selector;
}

@synthesize accessoryButtonTappedTarget = _accessoryButtonTappedTarget;
@synthesize accessoryButtonTappedSelector = _accessoryButtonTappedSelector;
- (void)addAccessoryButtonTappedEventTarget:(id)target selector:(SEL)selector
{
    NSAssert(sel_getArgumentsCount(selector) <= 1, @"Selector arguments count up to 1");
    _accessoryButtonTappedTarget = target;
    _accessoryButtonTappedSelector = selector;
}

#pragma mark - Reload

- (void)reloadData
{
    if (!_hasLayoutChanged && self.cell) {
        [self.cell setModel:self];
    }
    SUITableView *tableView = self.superTableView;
    _hasLayoutChanged = NO;
    [tableView reloadData];
}

- (void)reloadDataWithRowAnimation:(UITableViewRowAnimation)animation
{
    SUITableView *tableView = self.superTableView;
    NSIndexPath *cellOfIndex = self.indexPathInSuperTableView;
    _hasLayoutChanged = NO;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:cellOfIndex] withRowAnimation:animation];
}

#pragma mark - Init

- (id)init
{
    self = [self initWithStyle:UITableViewCellStyleDefault];
    if (self) {
        //Init code here.
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style
{
    self = [super init];
    if (self) {
        _style = style;
        _accessoryType = UITableViewCellAccessoryNone;
        _height = 44.0f;
        _hasLayoutChanged = NO;
    }
    return self;
}

@end
