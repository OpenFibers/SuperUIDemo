//
//  SimpleUITableView.h
//  SimpleUIDemo
//
//  Created by OpenThread on 10/31/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUISectionModel.h"
#import "SUIConstant.h"
#import "SUICellModelMapping.h"

//Begin of SUITableViewDelegate define

@class SUITableView;

@protocol SUITableViewDelegate <NSObject>

@optional

//The same function as UITableViewDelegate.
- (void)tableView:(SUITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(SUITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(SUITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
- (UITableViewCellEditingStyle)tableView:(SUITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(SUITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(SUITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(SUITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;

@end

//End of protocol define


@interface SUITableView : UITableView <UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSourceArray;
    id<SUITableViewDelegate> __unsafe_unretained _suiDelegate;
}

@property (nonatomic,assign) id<SUITableViewDelegate> suiDelegate;

/*
 Section count of self.
 */
@property (nonatomic,readonly,assign) NSUInteger sectionCount;

/*
 Array of sections.
 */
@property (nonatomic,readonly,assign) NSArray *sections;

/*
 Cell count of a section.
 */
- (NSUInteger)cellCountOfSectionAtIndex:(NSUInteger)index;

/*
 Add a section to this table view with no animation.
 */
- (void)addSectionModel:(SUISectionModel *)section;

/*
 Insert a section to this table view with index and no animation.
 */
- (void)insertSectionModel:(SUISectionModel *)section atIndex:(NSUInteger)index;

/*
 Remove a section of this table view with no animation.
 */
- (void)removeSectionModel:(SUISectionModel *)section;

/*
 Remove section at this index with no animation.
 */
- (void)removeSectionModelAtIndex:(NSUInteger)index;

/*
 Remove all section model with no animation.
 */
- (void)removeAllSectionModels;

/*
 Section at index in this table view.
 */
- (SUISectionModel *)sectionModelAtIndex:(NSUInteger)sectionIndex;

/*
 Cell at index path in this table view.
 */
- (SUICellModel *)cellModelAtIndexPath:(NSIndexPath *)indexPath;

/*
 Index of a section model in this table view.
 */
- (NSUInteger)indexOfSectionModel:(SUISectionModel *)sectionModel;

@end


