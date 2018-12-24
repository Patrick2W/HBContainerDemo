//
//  HBContainerTransitioningContext.h
//  HBContainer
//
//  Created by cheyun on 2018/7/19.
//  Copyright © 2018年 Patrick. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HBContainerTransitioningType){
    HBContainerTransitioningTypePresent,
    HBContainerTransitioningTypeDismiss
};

@class UIView;
@class UIViewController;
@interface HBContainerTransitioningContext : NSObject

- (instancetype)initWithTranstioningType:(HBContainerTransitioningType)type contentViewController:(UIViewController *)contentViewController;

@property (assign, nonatomic, readonly) HBContainerTransitioningType transitioningType;

@property (weak, nonatomic, readonly) UIViewController *contentViewController;

@property (weak, nonatomic, readonly) UIView *contentView;

@end
