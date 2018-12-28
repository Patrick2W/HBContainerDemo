//
//  HBContainerController.h
//  HBContainer
//
//  Created by cheyun on 2018/7/19.
//  Copyright © 2018年 Patrick. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBContainerTransitioning.h"
#import "HBContainerTransitioningContext.h"

/**
 出现的动画效果

 - HBContainerPresentAnimationStyleFade: 淡入淡出
 - HBContainerPresentAnimationStyleTopIn: 从顶部滑出
 - HBContainerPresentAnimationStyleLeftIn: 从左边滑出
 - HBContainerPresentAnimationStyleBottomIn: 从底部滑出
 - HBContainerPresentAnimationStyleRightIn: 从右边部滑出
 - HBContainerPresentAnimationStyleCenterSpringIn: 从中心弹出
 - HBContainerPresentAnimationStyleCustom: 自定义动画
 */
typedef NS_ENUM(NSUInteger, HBContainerPresentAnimationStyle) {
    HBContainerPresentAnimationStyleFade,
    HBContainerPresentAnimationStyleTopIn,
    HBContainerPresentAnimationStyleLeftIn,
    HBContainerPresentAnimationStyleBottomIn,
    HBContainerPresentAnimationStyleRightIn,
    HBContainerPresentAnimationStyleCenterSpringIn,
    HBContainerPresentAnimationStyleCustom
};

/**
 消失的动画效果
 
 - HBContainerDismissAnimationStyleFade: 淡入淡出
 - HBContainerDismissAnimationStyleTopOut: 从顶部消失
 - HBContainerDismissAnimationStyleLeftOut: 从左边消失
 - HBContainerDismissAnimationStyleBottomOut: 从底部消失
 - HBContainerDismissAnimationStyleRightOut: 从右边消失
 - HBContainerDismissAnimationStyleCenterSpringOut: 从中间消失
 - HBContainerDismissAnimationStyleCustom: 自定义动画
 */
typedef NS_ENUM(NSUInteger, HBContainerDismissAnimationStyle) {
    HBContainerDismissAnimationStyleFade,
    HBContainerDismissAnimationStyleTopOut,
    HBContainerDismissAnimationStyleLeftOut,
    HBContainerDismissAnimationStyleBottomOut,
    HBContainerDismissAnimationStyleRightOut,
    HBContainerDismissAnimationStyleCenterSpringOut,
    HBContainerDismissAnimationStyleCustom
};

@interface HBContainerController : UIViewController

/**
 *  初始化方法
 */
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;

/**
 设置出现与消失的动画

 @param presentAnimationStyle 出现的动画
 @param dismissAnimationStyle 消失的动画
 */
- (void)setPresentAnimationStyle:(HBContainerPresentAnimationStyle)presentAnimationStyle
           dismissAnimationStyle:(HBContainerDismissAnimationStyle)dismissAnimationStyle;


/**
 *  根控制器
 */
@property (strong, nonatomic, readonly) UIViewController *rootViewController;

/**
 *  当出现动画与消失动画为自定义时需要
 */
@property (weak, nonatomic) id<HBContainerTransitioning> transitioning;

/**
 *  背景
 */
@property (strong, nonatomic) UIView *backgroundView;

/**
 *  点击空白部分消失
 */
@property (assign, nonatomic) BOOL dismissWhenBlankTouched;

/**
 *  空白部分被点击的回调
 */
@property (copy, nonatomic) void(^blankTouchedBlock)(void);


/**
 *  是否需要响应 viewWillAppear: viewDidAppear:等方法
 *  默认响应
 */
@property (nonatomic, getter=isResponseAppearanceMethod) BOOL responseAppearanceMethod;


@end
