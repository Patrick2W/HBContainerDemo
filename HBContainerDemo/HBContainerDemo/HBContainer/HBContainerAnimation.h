//
//  HBContainerAnimation.h
//  HBContainer
//
//  Created by cheyun on 2018/7/20.
//  Copyright © 2018年 Patrick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBContainerTransitioning.h"
#import "HBContainerController.h"

@interface HBContainerAnimation : NSObject<HBContainerTransitioning>

- (instancetype)initWithPresentAnimationStyle:(HBContainerPresentAnimationStyle)presentAnimationStyle
                        dismissAnimationStyle:(HBContainerDismissAnimationStyle)dismissAnimationStyle;

@property (nonatomic, readonly) HBContainerPresentAnimationStyle presentAnimationStyle;
@property (nonatomic, readonly) HBContainerDismissAnimationStyle dismissAnimationStyle;

@end
