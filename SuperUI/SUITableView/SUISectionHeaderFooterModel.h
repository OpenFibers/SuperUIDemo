//
//  SUISectionHeaderFooterModel.h
//  SuperUIDemo
//
//  Created by OpenThread on 10/31/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SUISectionModel;

@interface SUISectionHeaderFooterModel : NSObject
{
    CGFloat _height;
    id __unsafe_unretained _superSectionModel;
    NSString *_textString;
    UIView *_view;
}

#pragma mark - Super

/*
 Super section of this header/footer.
 */
@property (nonatomic,assign) id superSectionModel;

/*
 Super table view of this header/footer.
 */
@property (nonatomic,readonly,assign) id superTableView;

/*
 Index of super section in super table view.
 */
@property (nonatomic,readonly,assign) NSUInteger indexInSuperTableView;

#pragma mark - Height

/*
 Height of this header/footer. 
 If this property is changed, view of this header/footer will be refreshed with no animation.
 */
@property (nonatomic,assign) CGFloat height;

/*
 Set height of this header/footer and refresh view with animation.
 */
- (void)setHeight:(CGFloat)height withRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - Content

/*
 String of header/footer.
 If this property was changed, string of this header/footer will be refreshed with no animation.
 */
@property (nonatomic,retain) NSString *textString;

/*
 Set string of this header/footer and refresh view with animation.
 */
- (void)setString:(NSString *)string withRowAnimation:(UITableViewRowAnimation)animation;

/*
 View of header/footer.
 If this property was changed, view of this header/footer will be refreshed with no animation.
 */
@property (nonatomic,retain) UIView *view;

/*
 Set view of this header/footer and refresh view with animation.
 */
- (void)setView:(UIView *)view withRowAnimation:(UITableViewRowAnimation)animation;

#pragma mark - Reload

/*
 Refresh table view with no animation.
 */
- (void)reloadData;

/*
 Refresh the view of super section with animation.
 */
- (void)reloadDataWithRowAnimation:(UITableViewRowAnimation)animation;


/*
 Init with super section model.
 */
- (id)initWithSuperSectionModel:(SUISectionModel *)superSectionModel;

@end