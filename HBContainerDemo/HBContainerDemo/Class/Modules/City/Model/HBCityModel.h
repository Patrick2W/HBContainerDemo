//
//  HBCityModel.h
//  HBContainerDemo
//
//  Created by cheyun on 2018/12/28.
//  Copyright © 2018 Patrick. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HBCityModel : NSObject

+ (instancetype)modelWithDictionary:(NSDictionary *)data;

@property (copy, nonatomic) NSString *local_name;
@property (copy, nonatomic) NSString *region_id;
@property (copy, nonatomic) NSArray *child;

@property (strong, nonatomic) NSArray *childModels;

@end

NS_ASSUME_NONNULL_END
