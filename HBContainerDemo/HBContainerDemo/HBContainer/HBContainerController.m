//
//  HBContainerController.m
//  HBContainer
//
//  Created by cheyun on 2018/7/19.
//  Copyright © 2018年 Patrick. All rights reserved.
//

#import "HBContainerController.h"
#import "HBContainerAnimation.h"
#import "UIViewController+HBAdd.h"

@interface HBContainerController ()<UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) HBContainerPresentAnimationStyle presentAnimationStyle;
@property (assign, nonatomic) HBContainerDismissAnimationStyle dismissAnimationStyle;

@property (strong, nonatomic) NSArray *superConstraints;
@property (strong, nonatomic) NSArray *currentConstraints;
@property (strong, nonatomic) NSArray *contentConstraints;

@end

@implementation HBContainerController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super init];
    if (self) {
        _rootViewController = rootViewController;
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initSome];
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.backgroundView = [UIView new];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)initSome {
    
    self.definesPresentationContext = YES;
    self.providesPresentationContextTransitionStyle = YES;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    self.responseAppearanceMethod = YES;
}

- (void)setPresentAnimationStyle:(HBContainerPresentAnimationStyle)presentAnimationStyle dismissAnimationStyle:(HBContainerDismissAnimationStyle)dismissAnimationStyle {
    self.presentAnimationStyle = presentAnimationStyle;
    self.dismissAnimationStyle = dismissAnimationStyle;
}

- (void)setBackgroundView:(UIView *)backgroundView {
    if (_backgroundView != backgroundView) {
        [_backgroundView removeFromSuperview];
        _backgroundView = backgroundView;
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view insertSubview:_backgroundView atIndex:0];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewDidTouch)];
        
        [_backgroundView addGestureRecognizer:tap];
    }
}

- (void)remakeConstraints {
    
    if (self.superConstraints.count > 0) {
        [self.view.superview removeConstraints:self.superConstraints];
        self.superConstraints = @[];
    }
    if (self.currentConstraints.count > 0) {
        [self.view removeConstraints:self.currentConstraints];
        self.contentConstraints = @[];
    }
    if (self.contentConstraints.count > 0) {
        [self.rootViewController.view removeConstraints:self.contentConstraints];
        self.contentConstraints = @[];
    }
    
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    self.rootViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.superConstraints = [self constraintsWithItem:self.view
                                               toItem:self.view.superview
                                         contentEdges:UIEdgeInsetsZero];
    [self.view.superview addConstraints:self.superConstraints];
    
    if (!CGSizeEqualToSize(CGSizeZero, self.rootViewController.hb_contentSize)) {
        
        
        self.contentConstraints = [self constraintsWithItem:self.rootViewController.view
                                                contentSize:self.rootViewController.hb_contentSize];
        self.currentConstraints = [self constraintsWithItem:self.rootViewController.view
                                                     toItem:self.view
                                               centerOffset:self.rootViewController.hb_centerOffSet];
        
        [self.view addConstraints:self.currentConstraints];
        [self.rootViewController.view addConstraints:self.contentConstraints];
    } else {
        
        self.currentConstraints = [self constraintsWithItem:self.rootViewController.view
                                                     toItem:self.view
                                               contentEdges:self.rootViewController.hb_contenteEdges];
        [self.view addConstraints:self.currentConstraints];
    }
}

- (NSArray *)constraintsWithItem:(UIView *)item1 toItem:(UIView *)item2 contentEdges:(UIEdgeInsets)edge {
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:item1
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:item2
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0
                                                                      constant:edge.top];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:item1
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:item2
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0
                                                                         constant:edge.bottom];
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:item1
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:item2
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:edge.left];
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:item1
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:item2
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                        constant:edge.right];
    return @[topConstraint, bottomConstraint, leftConstraint, rightConstraint];
}

- (NSArray *)constraintsWithItem:(UIView *)item contentSize:(CGSize)size {
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:item
                                                                       attribute:NSLayoutAttributeWidth
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0
                                                                        constant:size.width];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:item
                                                                       attribute:NSLayoutAttributeHeight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:nil
                                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                                      multiplier:1.0
                                                                        constant:size.height];
    return @[widthConstraint, heightConstraint];
}

- (NSArray *)constraintsWithItem:(UIView *)item1 toItem:(UIView *)item2 centerOffset:(CGPoint)center {
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:item1
                                                                         attribute:NSLayoutAttributeCenterX
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:item2
                                                                         attribute:NSLayoutAttributeCenterX
                                                                        multiplier:1.0
                                                                          constant:center.x];
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:item1
                                                                         attribute:NSLayoutAttributeCenterY
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:item2
                                                                         attribute:NSLayoutAttributeCenterY
                                                                        multiplier:1.0
                                                                          constant:center.y];
    return @[centerXConstraint, centerYConstraint];
}

#pragma mark - Action Method

- (void)backgroundViewDidTouch {
    
    if (self.dismissWhenBlankTouched) [self dismissViewControllerAnimated:YES completion:nil];
    !self.blankTouchedBlock ?: self.blankTouchedBlock();
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                   presentingController:(UIViewController *)presenting
                                                                       sourceController:(UIViewController *)source {
    return self;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    
    HBContainerTransitioningContext *context = [self convertTransitioningContext:transitionContext];
    id<HBContainerTransitioning> transitioning = [self transitioningWithContext:context];
    if ([transitioning respondsToSelector:@selector(containerControllerTransitionDuration:)]) {
        return [transitioning containerControllerTransitionDuration:context];
    }
    return 0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    /// 实现动画
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    HBContainerTransitioningContext *context = [self convertTransitioningContext:transitionContext];
    id<HBContainerTransitioning> transitioning = [self transitioningWithContext:context];
    NSTimeInterval timeInterval = 0;
    if ([transitioning respondsToSelector:@selector(containerControllerTransitionDuration:)]) {
        timeInterval = [transitioning containerControllerTransitionDuration:context];
    }
    if (context.transitioningType == HBContainerTransitioningTypePresent) {
        if (self.isResponseAppearanceMethod) {
            [fromViewController beginAppearanceTransition:NO animated:YES];
            [toViewController beginAppearanceTransition:YES animated:YES];
            [self.rootViewController beginAppearanceTransition:YES animated:YES];
        }
        
        [transitionContext.containerView addSubview:toViewController.view];
        
        [toViewController.view addSubview:self.rootViewController.view];
        [toViewController addChildViewController:self.rootViewController];
        
        [toViewController setNeedsStatusBarAppearanceUpdate];
        
        self.backgroundView.frame = self.view.bounds;
        self.backgroundView.alpha = 0;
        
        [self remakeConstraints];
        
        [UIView animateWithDuration:timeInterval animations:^{
            self.backgroundView.alpha = 1;
        }];
        
        void(^CompletionBlock)(void) = ^(){
            
            self.backgroundView.userInteractionEnabled = YES;
            self.view.userInteractionEnabled = YES;
            
            if (self.isResponseAppearanceMethod) {
                [toViewController endAppearanceTransition];
                [fromViewController endAppearanceTransition];
                [self.rootViewController endAppearanceTransition];
            }
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        };
        
        if ([transitioning respondsToSelector:@selector(containerControllerAnimationTransition:completion:)]) {
            [transitioning containerControllerAnimationTransition:context completion:^{
                CompletionBlock();
            }];
        } else {
            CompletionBlock();
        }
        
        
    } else {
        if (self.isResponseAppearanceMethod) {
            [toViewController beginAppearanceTransition:YES animated:YES];
//            [self.rootViewController beginAppearanceTransition:NO animated:YES];
            [fromViewController beginAppearanceTransition:NO animated:YES];
            [fromViewController willMoveToParentViewController:nil];
//            [self.rootViewController willMoveToParentViewController:nil];
        }
        
        self.backgroundView.userInteractionEnabled = NO;
        self.view.userInteractionEnabled = NO;
        
        [UIView animateWithDuration:timeInterval animations:^{
            self.backgroundView.alpha = 0;
        }];
        
        void(^CompletionBlock)(void) = ^(){
            
            self.backgroundView.userInteractionEnabled = YES;
            self.view.userInteractionEnabled = YES;
            [fromViewController.view removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            if (self.isResponseAppearanceMethod) {
//                [self.rootViewController endAppearanceTransition];
                [fromViewController endAppearanceTransition];
                [toViewController endAppearanceTransition];
            }
        };
        if ([transitioning respondsToSelector:@selector(containerControllerAnimationTransition:completion:)]) {
            [transitioning containerControllerAnimationTransition:context completion:^{
                CompletionBlock();
            }];
        } else {
            CompletionBlock();
        }
    }
}

- (HBContainerTransitioningContext *)convertTransitioningContext:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    HBContainerTransitioningType type = HBContainerTransitioningTypePresent;
    if ([transitionContext viewControllerForKey:UITransitionContextToViewControllerKey] != self) {
        type = HBContainerTransitioningTypeDismiss;
    }
    return [[HBContainerTransitioningContext alloc] initWithTranstioningType:type contentViewController:self.rootViewController];
}

- (id<HBContainerTransitioning>)transitioningWithContext:(HBContainerTransitioningContext *)context {
    id<HBContainerTransitioning> transitioning = nil;
    if (context.transitioningType == HBContainerTransitioningTypePresent && self.presentAnimationStyle == HBContainerPresentAnimationStyleCustom) {
        transitioning = self.transitioning;
    } else if (context.transitioningType == HBContainerTransitioningTypeDismiss && self.dismissAnimationStyle == HBContainerDismissAnimationStyleCustom) {
        transitioning = self.transitioning;
    } else {
        transitioning = [[HBContainerAnimation alloc] initWithPresentAnimationStyle:self.presentAnimationStyle dismissAnimationStyle:self.dismissAnimationStyle];
    }
    return transitioning;
}

@end
