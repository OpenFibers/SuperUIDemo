//
//  SimpleUITableView.m
//  SimpleUIDemo
//
//  Created by OpenThread on 10/31/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import "SUITableView.h"
#import "SUICell.h"
#import "SUIRuntime.h"

@implementation SUITableView

@synthesize suiDelegate = _suiDelegate;

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        // Initialization code here.
        _dataSourceArray = [[NSMutableArray alloc] init];
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - Property & Method

- (NSUInteger)sectionCount
{
    return [_dataSourceArray count];
}

- (NSArray *)sections
{
    NSArray *sectionArray = [NSArray arrayWithArray:_dataSourceArray];
    return sectionArray;
}

- (NSUInteger)cellCountOfSectionAtIndex:(NSUInteger)index
{
    SUISectionModel *sectionModel = [self sectionModelAtIndex:index];
    return [sectionModel cellCount];
}

- (void)addSectionModel:(SUISectionModel *)section
{
    [_dataSourceArray addObject:section];
    section.superTableView = self;
    [self reloadData];
}

- (void)insertSectionModel:(SUISectionModel *)section atIndex:(NSUInteger)index
{
    [_dataSourceArray insertObject:section atIndex:index];
    section.superTableView = self;
    [self reloadData];
}

- (void)removeSectionModel:(SUISectionModel *)section
{
    [_dataSourceArray removeObject:section];
    [self reloadData];
}

- (void)removeSectionModelAtIndex:(NSUInteger)index
{
    if (index < [_dataSourceArray count])
    {
        [_dataSourceArray removeObjectAtIndex:index];
        [self reloadData];
    }
    else
    {
        NSAssert(0, INDEX_BEYOND_ARRAY_BOUNDARY);
    }
}

- (void)removeAllSectionModels
{
    [_dataSourceArray removeAllObjects];
    [self reloadData];
}

- (SUISectionModel *)sectionModelAtIndex:(NSUInteger)index
{
    if (index < [_dataSourceArray count])
    {
        return [_dataSourceArray objectAtIndex:index];
    }
    else
    {
        NSAssert(0, INDEX_BEYOND_ARRAY_BOUNDARY);
    }
    return nil;
}

- (SUICellModel *)cellModelAtIndexPath:(NSIndexPath *)indexPath
{
    SUISectionModel *section = [self sectionModelAtIndex:indexPath.section];
    SUICellModel *cellModel = [section cellModelAtIndex:indexPath.row];
    return cellModel;
}

- (NSUInteger)indexOfSectionModel:(SUISectionModel *)sectionModel
{
    NSUInteger indexOfSectionModel = 0;
    indexOfSectionModel = [_dataSourceArray indexOfObject:sectionModel];
    return indexOfSectionModel;
}

#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{		
	if (_suiDelegate && [_suiDelegate respondsToSelector:@selector(scrollViewDidScroll:)])
    {
        [_suiDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_suiDelegate && [_suiDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
    {
        [_suiDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

#pragma mark - Numbers of Sections & Rows

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int dataSourceArrayCount = [_dataSourceArray count];
    return dataSourceArrayCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SUISectionModel *suiSection = (SUISectionModel *)[_dataSourceArray objectAtIndex:section];
    int cellCountOfSUISection = suiSection.cellCount;
    return cellCountOfSUISection;
}

#pragma mark - Cell - Data Source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SUICellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    CGFloat height = cellModel.height;
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SUICellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    NSString *reuseString = [[cellModel class] description];
    Class cellClass = [SUICellModelMapping cellClassForModel:cellModel];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseString];
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:cellModel.style reuseIdentifier:reuseString];
        objc_msgSend(cell, @selector(setSUISuperTableView:), self);
    }
    NSAssert([cell isKindOfClass:[SUICell class]], CELL_MUST_BE_A_SUICELL);
    SUICell *suiCell = (SUICell *)cell;
    [suiCell setModel:cellModel];
    return suiCell;
}

#pragma mark Cell - Select & Deselect

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SUICellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    if (cellModel.target && cellModel.tappedSelector) {
        int argCountOfSelector = sel_getArgumentCount(cellModel.tappedSelector);
        if (argCountOfSelector == 0) {
            objc_msgSend(cellModel.target, cellModel.tappedSelector);
        }
        else if (argCountOfSelector == 1)
        {
            objc_msgSend(cellModel.target, cellModel.tappedSelector, indexPath);
        }
    }
    if (_suiDelegate != nil && [_suiDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_suiDelegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_suiDelegate != nil && [_suiDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [_suiDelegate tableView:self didDeselectRowAtIndexPath:indexPath];
    }
}

#pragma mark Cell - Accessory Button

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    SUICellModel *cellModel = [self cellModelAtIndexPath:indexPath];
    if (cellModel.accessoryButtonTappedTarget && cellModel.accessoryButtonTappedSelector) {
        int argCountOfSelector = sel_getArgumentCount(cellModel.accessoryButtonTappedSelector);
        if (argCountOfSelector == 0) {
            objc_msgSend(cellModel.accessoryButtonTappedTarget, cellModel.accessoryButtonTappedSelector);
        }
        else if (argCountOfSelector == 1)
        {
            objc_msgSend(cellModel.accessoryButtonTappedTarget, cellModel.accessoryButtonTappedSelector, indexPath);
        }
    }
    if (_suiDelegate != nil && [_suiDelegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        [_suiDelegate tableView:self accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

#pragma mark Cell - Editing Cell

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_suiDelegate respondsToSelector:@selector(tableView:editingStyleForRowAtIndexPath:)]) {
        return [_suiDelegate tableView:self editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath];
    }
	return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_suiDelegate respondsToSelector:@selector(tableView:commitEditingStyle:forRowAtIndexPath:)]) {
        [_suiDelegate tableView:self commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_suiDelegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
        [_suiDelegate tableView:self willBeginEditingRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_suiDelegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
        [_suiDelegate tableView:self didEndEditingRowAtIndexPath:indexPath];
    }
}


#pragma mark - Header

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    SUISectionModel *sectionModel = [self sectionModelAtIndex:section];
    if (sectionModel.headerModel.textString) {
        if (self.style == UITableViewStylePlain) {
            return 22.0f;
        }
        else
        {
            return 44.0f;
        }
    }
    int heightForHeader = sectionModel.headerModel.height;
    return heightForHeader;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SUISectionModel *sectionModel = [self sectionModelAtIndex:section];
    SUISectionHeaderModel *headerModel = sectionModel.headerModel;
    if (headerModel.textString) {
        return headerModel.textString;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SUISectionModel *sectionModel = [self sectionModelAtIndex:section];
    SUISectionHeaderModel *headerModel = sectionModel.headerModel;
    if (headerModel.view) {
        return headerModel.view;
    }
    return nil;
}

#pragma mark - Footer

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    SUISectionModel *sectionModel = [self sectionModelAtIndex:section];
    if (sectionModel.footerModel.textString)
    {
        if (self.style == UITableViewStylePlain)
        {
            return 22.0f;
        }
        else
        {
            return 30.0f;
        }
    }
    int heightForFooter = sectionModel.footerModel.height;
    return heightForFooter;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    SUISectionModel *sectionModel = [self sectionModelAtIndex:section];
    SUISectionFooterModel *footerModel = sectionModel.footerModel;
    if (footerModel) {
        return footerModel.textString;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    SUISectionModel *sectionModel = [self sectionModelAtIndex:section];
    SUISectionFooterModel *footerModel = sectionModel.footerModel;
    if (footerModel) {
        return footerModel.view;
    }
    return nil;
}

@end
