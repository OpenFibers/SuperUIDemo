//
//  SUITableViewCell.h
//  SuperUIDemo
//
//  Created by OpenThread on 10/31/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SUICell;
@class SUITableView;

@interface SUICellModel : NSObject
{
    //Layout
    UITableViewCellStyle _style;
    CGFloat _height;
    UITableViewCellAccessoryType _accessoryType;
    BOOL _hasLayoutChanged;//用于判断_height是否有变更。若有变更，则刷新整个SUITableView；否则为内容变更，只[_cell setModel:].
    
    //Super model
    id __unsafe_unretained _superSectionModel;
    
    //Data model
    NSString *_textLabelString;
    NSString *_detailLabelString;
    UIImage *_image;
    
    //Touched event
    id __unsafe_unretained _target;
    SEL _tappedSelector;
    
    //Accessory button tapped event
    id __unsafe_unretained _accessoryButtonTappedTarget;
    SEL _accessoryButtonTappedSelector;
}

#pragma mark - Pointer of displayed cell

@property (nonatomic,getter = cell,readonly) SUICell *cell;

#pragma mark - Layout

/*
 Get the style of this cell.
 This value only be set once at init time.
 */
@property (nonatomic,readonly) UITableViewCellStyle style;

/*
 Height of this cell. 
 If this property is changed, view of this cell will be refreshed with no animation.
 */
@property (nonatomic,assign) CGFloat height;

/*
 Set height of this cell and refresh with animation.
 */
- (void)setHeight:(CGFloat)height withRowAnimation:(UITableViewRowAnimation)animation;

/*
 Change the accessory type of this cell.
 */
@property (nonatomic,assign) UITableViewCellAccessoryType accessoryType;

#pragma mark - Data model

/*
 Configure the string on text label of UITableViewCell.
 */
@property (nonatomic,retain) NSString *textLabelString;

/*
 Configure the string on detail label of UITableViewCell.
 */
@property (nonatomic,retain) NSString *detailLabelString;

/*
 Configure the image in image view of UITableViewCell.
 */
@property (nonatomic,retain) UIImage *image;

#pragma mark - Super model

/*
 Super section of this cell.
 Don't change this value.
 */
@property (nonatomic,assign) id superSectionModel;

/*
 Super table view of this cell.
 */
@property (nonatomic,readonly,assign) SUITableView* superTableView;

/*
 Index of this cell in super section.
 */
@property (nonatomic,readonly,assign) NSUInteger indexInSuperSection;

/*
 Index path of this cell in super table view.
 */
@property (nonatomic,readonly,assign) NSIndexPath *indexPathInSuperTableView;

#pragma mark - Events

/*
 Target of selected event.
 */
@property (nonatomic,readonly,assign) id target;

/*
 Selector of selected event.
 */
@property (nonatomic,readonly,assign) SEL tappedSelector;

/*
 Set target and selector for touched inside event.
 WARNING:The selector should not take more than 1 parameter.Or an NSAssert will come out.
 If the selector take 1 param, the only param will be the index of selected cell.
 */
- (void)addSelectedEventTarget:(id)target selector:(SEL)selector;

/*
 Target of accessory button tapped event.
 */
@property (nonatomic,readonly,assign) id accessoryButtonTappedTarget;

/*
 Selector of accessory button tapped event.
 */
@property (nonatomic,readonly,assign) SEL accessoryButtonTappedSelector;

/*
 Set target and selector for accessory button tapped event.
 WARNING:The selector should not take more than 1 parameter.Or an NSAssert will come out.
 If the selector take 1 param, the only param will be the index of accessory button tapped cell.
 */
- (void)addAccessoryButtonTappedEventTarget:(id)target selector:(SEL)selector;

#pragma mark - Reload

/*
 Refresh table view with no animation.
 */
- (void)reloadData;

/*
 Refresh the view of this cell with animation.
 */
- (void)reloadDataWithRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - Init

/*
 Init with default style UITableViewCellStyleDefault.
 */
- (id)init;

/*
 Init with a UITableViewCellStyle.
 */
- (id)initWithStyle:(UITableViewCellStyle)style;

@end
