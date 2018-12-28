//
//  HBContainerAnimation.m
//  HBContainer
//
//  Created by cheyun on 2018/7/20.
//  Copyright © 2018年 Patrick. All rights reserved.
//

#import "HBContainerAnimation.h"
#import "HBContainerTransitioningContext.h"
#import "UIViewController+HBAdd.h"

@implementation HBContainerAnimation

- (instancetype)initWithPresentAnimationStyle:(HBContainerPresentAnimationStyle)presentAnimationStyle dismissAnimationStyle:(HBContainerDismissAnimationStyle)dismissAnimationStyle {
    self = [super init];
    if (self) {
        _presentAnimationStyle = presentAnimationStyle;
        _dismissAnimationStyle = dismissAnimationStyle;
    }
    return self;
}

- (NSTimeInterval)containerControllerTransitionDuration:(HBContainerTransitioningContext *)context {
    
    return 0.25;
}

- (void)containerControllerAnimationTransition:(HBContainerTransitioningContext *)context completion:(void(^)(void))completion {
    
    
    if (context.transitioningType == HBContainerTransitioningTypePresent) {
        if (self.presentAnimationStyle == HBContainerPresentAnimationStyleTopIn) {
            
            [self topInAnimationWithContext:context completion:completion];
            
        } else if (self.presentAnimationStyle == HBContainerPresentAnimationStyleLeftIn) {
            
            [self leftInAnimationWithContext:context completion:completion];
            
        } else if (self.presentAnimationStyle == HBContainerPresentAnimationStyleBottomIn) {
            
            [self bottomInAnimationWithContext:context completion:completion];
            
        } else if (self.presentAnimationStyle == HBContainerPresentAnimationStyleRightIn) {
            
            [self rightInAnimationWithContext:context completion:completion];
            
        } else if (self.presentAnimationStyle == HBContainerPresentAnimationStyleCenterSpringIn) {
            
            [self centerSpringInAnimationWithContext:context completion:completion];
            
        } else {
            [self fadeShowAnimationWithContext:context completion:completion];
        }
    } else {
        if (self.dismissAnimationStyle == HBContainerDismissAnimationStyleTopOut) {
            
            [self topOutAnimationWithContext:context completion:completion];
            
        } else if (self.dismissAnimationStyle == HBContainerDismissAnimationStyleLeftOut) {
            
            [self leftOutAnimationWithContext:context completion:completion];
            
        } else if (self.dismissAnimationStyle == HBContainerDismissAnimationStyleBottomOut) {
            
            [self bottomOutAnimationWithContext:context completion:completion];
            
        } else if (self.dismissAnimationStyle == HBContainerDismissAnimationStyleRightOut) {
            
            [self rightOutAnimationWithContext:context completion:completion];
            
        } else if (self.dismissAnimationStyle == HBContainerDismissAnimationStyleCenterSpringOut) {
            
            [self centerSpringOutAnimationWithContext:context completion:completion];
            
        } else {
            
            [self fadeDismissAnimationWithContext:context completion:completion];
        }
    }
}

- (void)fadeShowAnimationWithContext:(HBContainerTransitioningContext *)context completion:(void(^)(void))completion {
    
    UIView *contentView = context.contentView;
    contentView.alpha = 0;
    
    [UIView animateWithDuration:[self containerControllerTransitionDuration:context]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         contentView.alpha = 1;
                     } completion:^(BOOL finished) {
                         completion();
                     }];
}

- (void)fadeDismissAnimationWithContext:(HBContainerTransitioningContext *)context completion:(void(^)(void))completion {
    UIView *contentView = context.contentView;
    
    [UIView animateWithDuration:[self containerControllerTransitionDuration:context]
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         contentView.alpha = 0;
                     } completion:^(BOOL finished) {
                         contentView.alpha = 1;
                         completion();
                     }];
}

- (void)topInAnimationWithContext:(HBContainerTransitioningContext *)context completion:(void(^)(void))completion {
    CGSize superSize = context.contentView.superview.frame.size;
    UIViewController *contentVC = context.contentViewController;
    CGFloat maxY = 0;
    if (!CGSizeEqualToSize(CGSizeZero, contentVC.hb_contentSize)) {
        maxY = (superSize.height + contentVC.hb_contentSize.height) / 2.0 + contentVC.hb_centerOffSet.y;
    } else {
        maxY = superSize.height - contentVC.hb_contenteEdges.bottom;
    }
    context.contentView.transform = CGAffineTransformMakeTranslation(0, -maxY);
    [UIView animateWithDuration:[self containerControllerTransitionDuration:context] animations:^{
        context.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        completion();
    }];
}

- (void)rightInAnimationWithContext:(HBContainerTransitioningContext *)context completion:(void(^)(void))completion {
    CGSize superSize = context.contentView.superview.frame.size;
    UIViewController *contentVC = context.contentViewController;
    CGFloat rightX = 0;
    if (!CGSizeEqualToSize(CGSizeZero, contentVC.hb_contentSize)) {
        rightX = (superSize.width + contentVC.hb_contentSize.width) / 2.0 - contentVC.hb_centerOffSet.x;
    } else {
        rightX = superSize.width - contentVC.hb_contenteEdges.left;
    }
    context.contentView.transform = CGAffineTransformMakeTranslation(rightX, 0);
    [UIView animateWithDuration:[self containerControllerTransitionDuration:context] animations:^{
        context.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        completion();
    }];
}

- (void)bottomInAnimationWithContext:(HBContainerTransitioningContext *)context completion:(void(^)(void))completion {
    CGSize superSize = context.contentView.superview.frame.size;
    UIViewController *contentVC = context.contentViewController;
    CGFloat bottomY = 0;
    if (!CGSizeEqualToSize(CGSizeZero, contentVC.hb_contentSize)) {
        bottomY = (superSize.height + contentVC.hb_contentSize.height) / 2.0 - contentVC.hb_centerOffSet.y;
    } else {
        bottomY = superSize.height - contentVC.hb_contenteEdges.top;
    }
    context.contentView.transform = CGAffineTransformMakeTranslation(0, bottomY);
    [UIView animateWithDuration:[self containerControllerTransitionDuration:context] animations:^{
        context.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        completion();
    }];
}

- (void)leftInAnimationWithContext:(HBContainerTransitioningContext *)context completion:(void(^)(void))completion {
    CGSize superSize = context.contentView.superview.frame.size;
    UIViewController *contentVC = context.contentViewController;
    CGFloat maxX = 0;
    if (!CGSizeEqualToSize(CGSizeZero, contentVC.hb_contentSize)) {
        maxX = (superSize.width + contentVC.hb_contentSize.width) / 2.0 + contentVC.hb_centerOffSet.x;
    } else {
        maxX = superSize.width - contentVC.hb_contenteEdges.right;
    }
    context.contentView.transform = CGAffineTransformMakeTranslation(-maxX, 0);
    [UIView animateWithDuration:[self containerControllerTransitionDuration:context] animations:^{
        context.contentView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        completion();
    }];
}

- (void)centerSpringInAnimationWithContext:(HBContainerTransitioningContext *)context completion:(void(^)(void))completion {
    context.contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    CGFloat alpha = context.contentView.alpha;
    context.contentView.alpha = 0.0;
    [UIView animateWithDuration:[self containerControllerTransitionDuration:context] delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        context.contentView.transform = CGAffineTransformIdentity;
        context.contentView.alpha = alpha;
    } completion:^(BOOL finished) {
        context.contentView.alpha = alpha;
        completion();
    }];
}

- (void)topOutAnimationWithContext:(HBContainerTransitioningContext *)context completion:(void(^)(void))completion {
    CGSize superSize = context.contentView.superview.frame.size;
    UIViewController *contentVC = context.contentViewController;
    CGFloat bottom = 0;
    if (!CGSizeEqualToSize(CGSizeZero, contentVC.hb_contentSize)) {
        bottom = (superSize.height + contentVC.hb_contentSize.height) / 2.0 + contentVC.hb_centerOffSet.y;
    } else {
        bottom = superSize.height - contentVC.hb_contenteEdges.bottom;
    }
    [UIView animateWithDuration:[self containerControllerTransitionDuration:context] animations:^{
        context.contentView.transform = CGAffineTransformMakeTranslation(0, -bottom);
    } completion:^(BOOL finished) {
        context.contentView.transform = CGAffineTransformIdentity;
        completion();
    }];
}

- (void)rightOutAnimationWithContext:(HBContainerTransitioningContext *)context completion:(void(^)(void))completion {
    CGSize superSize = context.contentView.superview.frame.size;
    UIViewController *contentVC = context.contentViewController;
    CGFloat rightX = 0;
    if (!CGSizeEqualToSize(CGSizeZero, contentVC.hb_contentSize)) {
        rightX = (superSize.width + contentVC.hb_contentSize.width) / 2.0 - contentVC.hb_centerOffSet.x;
    } else {
        rightX = superSize.width - contentVC.hb_contenteEdges.left;
    }
    [UIView animateWithDuration:[self containerControllerTransitionDuration:context] animations:^{
        context.contentView.transform = CGAffineTransformMakeTranslation(rightX, 0);
    } completion:^(BOOL finished) {
        context.contentView.transform = CGAffineTransformIdentity;
        completion();
    }];
}

- (void)bottomOutAnimationWithContext:(HBContainerTransitioningContext *)context completion:(void(^)(void))completion {
    CGSize superSize = context.contentView.superview.frame.size;
    UIViewController *contentVC = context.contentViewController;
    CGFloat bottomY = 0;
    if (!CGSizeEqualToSize(CGSizeZero, contentVC.hb_contentSize)) {
        bottomY = (superSize.height + contentVC.hb_contentSize.height) / 2.0 - contentVC.hb_centerOffSet.y;
    } else {
        bottomY = superSize.height - contentVC.hb_contenteEdges.top;
    }
    [UIView animateWithDuration:[self containerControllerTransitionDuration:context] animations:^{
        context.contentView.transform = CGAffineTransformMakeTranslation(0, bottomY);
    } completion:^(BOOL finished) {
        context.contentView.transform = CGAffineTransformIdentity;
        completion();
    }];
}

- (void)leftOutAnimationWithContext:(HBContainerTransitioningContext *)context completion:(void(^)(void))completion {
    CGSize superSize = context.contentView.superview.frame.size;
    UIViewController *contentVC = context.contentViewController;
    CGFloat maxX = 0;
    if (!CGSizeEqualToSize(CGSizeZero, contentVC.hb_contentSize)) {
        maxX = (superSize.width + contentVC.hb_contentSize.width) / 2.0 + contentVC.hb_centerOffSet.x;
    } else {
        maxX = superSize.width - contentVC.hb_contenteEdges.right;
    }
    [UIView animateWithDuration:[self containerControllerTransitionDuration:context] animations:^{
        context.contentView.transform = CGAffineTransformMakeTranslation(-maxX, 0);
    } completion:^(BOOL finished) {
        context.contentView.transform = CGAffineTransformIdentity;
        completion();
    }];
}

- (void)centerSpringOutAnimationWithContext:(HBContainerTransitioningContext *)context completion:(void(^)(void))completion {
    CGFloat alpha = context.contentView.alpha;
    [UIView animateWithDuration:[self containerControllerTransitionDuration:context] delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        context.contentView.transform = CGAffineTransformMakeScale(0.1, 0.1);
        context.contentView.alpha = 0.0;
    } completion:^(BOOL finished) {
        context.contentView.transform = CGAffineTransformIdentity;
        context.contentView.alpha = alpha;
        completion();
    }];
}

@end
