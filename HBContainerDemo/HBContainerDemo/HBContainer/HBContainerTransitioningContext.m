//
//  HBContainerTransitioningContext.m
//  HBContainer
//
//  Created by cheyun on 2018/7/19.
//  Copyright © 2018年 Patrick. All rights reserved.
//

#import "HBContainerTransitioningContext.h"
#import <UIKit/UIKit.h>

@implementation HBContainerTransitioningContext

- (instancetype)initWithTranstioningType:(HBContainerTransitioningType)type contentViewController:(UIViewController *)contentViewController {
    self = [super init];
    if (self) {
        _transitioningType = type;
        _contentViewController = contentViewController;
        _contentView = contentViewController.view;
        
    }
    return self;
}

@end
