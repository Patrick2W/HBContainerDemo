//
//  HBCityModel.m
//  HBContainerDemo
//
//  Created by cheyun on 2018/12/28.
//  Copyright © 2018 Patrick. All rights reserved.
//

#import "HBCityModel.h"

@implementation HBCityModel

+ (instancetype)modelWithDictionary:(NSDictionary *)data {
    HBCityModel *model = [HBCityModel new];
    model.local_name = data[@"local_name"];
    model.region_id = data[@"region_id"];
    model.child = data[@"child"];
    return model;
}

- (void)setChild:(NSArray *)child {
    _child = child;
    NSMutableArray *models = [NSMutableArray array];
    for (NSDictionary *element in child) {
        HBCityModel *model = [HBCityModel modelWithDictionary:element];
        [models addObject:model];
    }
    self.childModels = models;
}

@end
