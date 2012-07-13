//
//  SUITableSection.h
//  SuperUIDemo
//
//  Created by OpenThread on 10/31/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUICellModel.h"
#import "SUISectionHeaderModel.h"
#import "SUISectionFooterModel.h"

@interface SUISectionModel : NSObject
{
    NSMutableArray *_cellDataSourceArray;
    SUISectionHeaderModel *_headerModel;
    SUISectionFooterModel *_footerModel;
    id __unsafe_unretained _superTableView;
}

#pragma mark - Super

/*
 Super table view of this section.
 Don't change this value.
 */
@property (nonatomic,assign) id superTableView;

/*
 Index of this section in super table view.
 */
@property (nonatomic,readonly,assign) NSUInteger indexInSuperTable;

#pragma mark - Header

/*
 Header model of this section.
 If this property is changed, super table view will be refreshed with no animation.
 If this property is assigned to nil, header view of this section will be removed.
 */
@property (nonatomic,retain) SUISectionHeaderModel *headerModel;

/*
 Init header if header is nil.
 */
- (void)initHeader;

/*
 Change header model with animation.
 If the first arg is nil, header view of this section will be removed.
 */
- (void)setHeaderModel:(SUISectionHeaderModel *)headerModel withRowAnimation:(UITableViewRowAnimation)animation;

/* 
 Remove header model of this section with no animation.
 */
- (void)removeHeader;

/* 
 Remove header model of this section with animation.
 */
- (void)removeHeaderWithRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - Footer

/*
 Footer model of this section.
 If this property is changed, super table view will be refreshed with no animation.
 If this property is assigned to nil, footer view of this section will be removed.
 */
@property (nonatomic,retain) SUISectionFooterModel *footerModel;

/*
 Init footer if footer is nil.
 */
- (void)initFooter;

/*
 Change footer model with animation.
 If the first arg is nil, footer view of this section will be removed.
 */
- (void)setFooterModel:(SUISectionFooterModel *)footerModel withRowAnimation:(UITableViewRowAnimation)animation;

/*
 Remove footer of this section with no animation.
 */
- (void)removeFooter;

/* 
 Remove footer model of this section with animation.
 */
- (void)removeFooterWithRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - Cell

/*
 Add a cell model to this section with no animation.
 */
- (void)addCellModel:(SUICellModel *)cellModel;

/*
 Add a cell model to this section with animation.
 */
- (void)addCellModel:(SUICellModel *)cellModel withRowAnimation:(UITableViewRowAnimation)animation;

/*
 Insert cell model to this section at index.
 */
- (void)insertCellModel:(SUICellModel *)cellModel atIndex:(NSUInteger)index;

/*
 Insert cell model to this section at index with animation.
 */
- (void)insertCellModel:(SUICellModel *)cellModel atIndex:(NSUInteger)index withRowAnimation:(UITableViewRowAnimation)animation;

/*
 Remove a cell model with no animation.
 */
- (void)removeCellModel:(SUICellModel *)cellModel;

/*
 Remove a cell model with animation.
 */
- (void)removeCellModel:(SUICellModel *)cellModel withRowAnimation:(UITableViewRowAnimation)animation;

/*
 Remove cell model at this index with no animation.
 */
- (void)removeCellModelAtIndex:(NSUInteger)index;

/*
 Remove cell model at this index with animation.
 */
- (void)removeCellModelAtIndex:(NSUInteger)index withRowAnimation:(UITableViewRowAnimation)animation;

/*
 Remove all cell model in this section.
 */
- (void)removeAllCellModels;

/*
 Total cell count in this section.
 */
@property (nonatomic,readonly,assign) NSUInteger cellCount;

/*
 Array of cells.
 */
@property (nonatomic,readonly,assign) NSArray *cells;

/*
 Get cell in this section by index.
 */
- (SUICellModel *)cellModelAtIndex:(NSUInteger)rowIndex;

/*
 Get index of a cell in this section.
 */
- (NSUInteger)indexOfCellModel:(SUICellModel *)cellModel;

#pragma mark Reload

/*
 Refresh table view with no animation.
 */
- (void)reloadData;

/*
 Refresh the view of super section with animation.
 */
- (void)reloadDataWithRowAnimation:(UITableViewRowAnimation)animation;

@end
