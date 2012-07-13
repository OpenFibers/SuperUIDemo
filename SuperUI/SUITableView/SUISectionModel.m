//
//  SUITableSection.m
//  SuperUIDemo
//
//  Created by OpenThread on 10/31/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import "SUISectionModel.h"
#import "SUITableView.h"

@implementation SUISectionModel

#pragma mark - Super

@synthesize superTableView = _superTableView;

- (NSUInteger)indexInSuperTable
{
    SUITableView *superTableView = self.superTableView;
    NSUInteger indexOfSelfInSUITable = [superTableView indexOfSectionModel:self];
    return indexOfSelfInSUITable;
}

#pragma mark - Header

- (void)initHeader
{
    if (!_headerModel) {
        _headerModel = [[SUISectionHeaderModel alloc] initWithSuperSectionModel:self];
    }
}

- (SUISectionHeaderModel *)headerModel
{
    return _headerModel;
}

- (void)setHeaderModel:(SUISectionHeaderModel *)headerModel
{
    _headerModel.superSectionModel = nil;
    _headerModel = headerModel;
    _headerModel.superSectionModel = self;
    [self reloadData];
}

- (void)setHeaderModel:(SUISectionHeaderModel *)headerModel withRowAnimation:(UITableViewRowAnimation)animation
{
    _headerModel.superSectionModel = nil;
    _headerModel = headerModel;
    _headerModel.superSectionModel = self;
    [self reloadDataWithRowAnimation:animation];
}

- (void)removeHeader
{
    self.headerModel = nil;
}

- (void)removeHeaderWithRowAnimation:(UITableViewRowAnimation)animation
{
    [self setHeaderModel:nil withRowAnimation:animation];
}

#pragma mark - Footer

- (void)initFooter
{
    if (!_footerModel) {
        _footerModel = [[SUISectionFooterModel alloc] initWithSuperSectionModel:self];
    }
}

- (SUISectionFooterModel *)footerModel
{
    return _footerModel;
}

- (void)setFooterModel:(SUISectionFooterModel *)footerModel
{
    _footerModel.superSectionModel = nil;
    _footerModel = footerModel;
    _footerModel.superSectionModel = self;
    [self reloadData];
}

- (void)setFooterModel:(SUISectionFooterModel *)footerModel withRowAnimation:(UITableViewRowAnimation)animation
{
    _footerModel.superSectionModel = nil;
    _footerModel = footerModel;
    _footerModel.superSectionModel = self;
    [self reloadDataWithRowAnimation:animation];
}

- (void)removeFooter
{
    self.footerModel = nil;
}

- (void)removeFooterWithRowAnimation:(UITableViewRowAnimation)animation
{
    [self setFooterModel:nil withRowAnimation:animation];
}

#pragma mark - Cell

- (void)addCellModel:(SUICellModel *)cellModel
{
    [self addCellModel:cellModel withRowAnimation:UITableViewRowAnimationNone];
}

- (void)addCellModel:(SUICellModel *)cellModel withRowAnimation:(UITableViewRowAnimation)animation
{
    [self insertCellModel:cellModel atIndex:self.cellCount withRowAnimation:animation];
}

- (void)insertCellModel:(SUICellModel *)cellModel atIndex:(NSUInteger)index
{
    [self insertCellModel:cellModel atIndex:index withRowAnimation:UITableViewRowAnimationNone];
}

- (void)insertCellModel:(SUICellModel *)cellModel atIndex:(NSUInteger)index withRowAnimation:(UITableViewRowAnimation)animation
{
    NSUInteger section = [self.superTableView indexOfSectionModel:self];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
    [self.superTableView beginUpdates];
    [_cellDataSourceArray insertObject:cellModel atIndex:index];
    cellModel.superSectionModel = self;
    [self.superTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:animation];
    [self.superTableView endUpdates];
}

- (void)removeCellModel:(SUICellModel *)cellModel
{
    [self removeCellModel:cellModel withRowAnimation:UITableViewRowAnimationNone];
}

- (void)removeCellModel:(SUICellModel *)cellModel withRowAnimation:(UITableViewRowAnimation)animation
{
    NSUInteger row = [self indexOfCellModel:cellModel];
    if (row != NSNotFound)
    {
        [self removeCellModelAtIndex:row withRowAnimation:animation];
    }
    else
    {
        NSAssert(row != NSNotFound, CELL_MODEL_NOT_IN_SECTION);
    }
}

- (void)removeCellModelAtIndex:(NSUInteger)index
{
    [self removeCellModelAtIndex:index withRowAnimation:UITableViewRowAnimationNone];
}

- (void)removeCellModelAtIndex:(NSUInteger)index withRowAnimation:(UITableViewRowAnimation)animation
{
    if (index < [_cellDataSourceArray count])
    {
        NSUInteger section = [self.superTableView indexOfSectionModel:self];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:section];
        [self.superTableView beginUpdates];
        [_cellDataSourceArray removeObjectAtIndex:index];
        [self.superTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:animation];
        [self.superTableView endUpdates];
    }
    else
    {
        NSAssert(0, INDEX_BEYOND_ARRAY_BOUNDARY);
    }
}

- (void)removeAllCellModels
{
    [_cellDataSourceArray removeAllObjects];
    [self reloadData];
}

- (NSUInteger)cellCount
{
    NSUInteger cellDataSourceArrayCount = [_cellDataSourceArray count];
    return cellDataSourceArrayCount;
}

- (NSArray *)cells
{
    NSArray *cellArray = [NSArray arrayWithArray:_cellDataSourceArray];
    return cellArray;
}

- (SUICellModel *)cellModelAtIndex:(NSUInteger)rowIndex
{
    if (rowIndex < [_cellDataSourceArray count])
    {
        return [_cellDataSourceArray objectAtIndex:rowIndex];
    }
    else
    {
        NSAssert(0, INDEX_BEYOND_ARRAY_BOUNDARY);
    }
    return nil;
}

- (NSUInteger)indexOfCellModel:(SUICellModel *)cellModel
{
    NSUInteger indexOfCell = [_cellDataSourceArray indexOfObject:cellModel];
    return indexOfCell;
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
    NSUInteger indexInTableView = self.indexInSuperTable;
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:indexInTableView];
    [tableView reloadSections:indexSet withRowAnimation:animation];
}

#pragma mark - Init

- (id)init
{
    self = [super init];
    if (self) {
        _cellDataSourceArray = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
