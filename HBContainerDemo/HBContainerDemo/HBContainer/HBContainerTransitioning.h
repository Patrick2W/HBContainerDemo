//
//  HBContainerTransitioning.h
//  HBContainer
//
//  Created by cheyun on 2018/7/19.
//  Copyright © 2018年 Patrick. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HBContainerTransitioningContext;
@protocol HBContainerTransitioning <NSObject>

- (NSTimeInterval)containerControllerTransitionDuration:(HBContainerTransitioningContext *)context;

- (void)containerControllerAnimationTransition:(HBContainerTransitioningContext *)context completion:(void(^)(void))completion;

@end
