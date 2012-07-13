//
//  SUIModelMapping.m
//  SuperUIDemo
//
//  Created by OpenThread on 11/9/11.
//  Copyright (c) 2011 25 O'clock Inc. All rights reserved.
//

#import "SUICellModelMapping.h"
#import "SUICell.h"

@implementation SUICellModelMapping

- (Class)cellClassForModelClassString:(NSString *)modelString
{
    Class cellClass = [_modelMappingDictionary objectForKey:modelString];
    return cellClass;
}

- (void)addMappedCellClass:(Class)cellClass forCellModelClass:(Class)cellModelClass
{
    NSString *modelClassString = [cellModelClass description];
    [_modelMappingDictionary setObject:cellClass forKey:modelClassString];
}

+ (id)instance
{
	static id obj = nil;
	if( nil == obj ) {
		obj = [[self alloc] init];
	}
	return obj;	
}

+ (void)addMappedCellClass:(Class)cellClass forCellModelClass:(Class)cellModelClass
{
    [[SUICellModelMapping instance] addMappedCellClass:cellClass forCellModelClass:cellModelClass];
}

+ (Class)cellClassForModelClassString:(NSString *)modelString
{
    Class cellClass = [[SUICellModelMapping instance] cellClassForModelClassString:modelString];
    return cellClass;
}

+ (Class)cellClassForModel:(SUICellModel *)cellModel
{
    NSString *modelClassString = [[cellModel class] description];
    Class cellClass = [[SUICellModelMapping instance] cellClassForModelClassString:modelClassString];
    return cellClass;
}

- (id)init
{
    self = [super init];
    if (self) {
        _modelMappingDictionary = [[NSMutableDictionary alloc] init];
        [_modelMappingDictionary setObject:[SUICell class] forKey:[[SUICellModel class] description]];
    }
    return self;
}

@end
