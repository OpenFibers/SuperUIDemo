//
//  SUIModelMapping.h
//  SuperUIDemo
//
//  Created by OpenThread on 11/9/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SUICellModel.h"

@interface SUICellModelMapping : NSObject
{
    NSMutableDictionary *_modelMappingDictionary;
}

/*
 Add a cell - model pair in model mapping.
 If a model class is already mapped, old cell class corresponds to the existing model class will be replaced by the new one.
 */
+ (void)addMappedCellClass:(Class)cellClass forCellModelClass:(Class)cellModelClass;

/*
 Returns the cell class corresponds to the model class string.
 */
+ (Class)cellClassForModelClassString:(NSString *)modelString;

/*
 Returns the cell class corresponds to the model's class;
 */
+ (Class)cellClassForModel:(SUICellModel *)cellModel;

@end
