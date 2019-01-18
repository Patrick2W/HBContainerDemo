//
//  HBCartViewController.m
//  HBContainerDemo
//
//  Created by cheyun on 2018/12/28.
//  Copyright © 2018 Patrick. All rights reserved.
//

#import "HBCartViewController.h"
#import "HBContainer.h"


#define Random255 (arc4random_uniform(256)/255.0)
#define RandomColor [UIColor colorWithRed:Random255 green:Random255 blue:Random255 alpha:1]



@interface HBCartViewController ()

@property (strong, nonatomic) UIButton *nextButton;

@end

@implementation HBCartViewController


+ (HBCartViewController *)showCartPage:(UIViewController *)caller {
    HBCartViewController *vc = [[HBCartViewController alloc] init];
    HBContainerController *container = [[HBContainerController alloc] initWithRootViewController:vc];
    container.dismissWhenBlankTouched = YES;
    [container setPresentAnimationStyle:HBContainerPresentAnimationStyleBottomIn
                  dismissAnimationStyle:HBContainerDismissAnimationStyleBottomOut];
    [caller presentViewController:container animated:YES completion:nil];
    return vc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RandomColor;
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextButton.backgroundColor = RandomColor;
    [self.nextButton addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.nextButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    CGSize size = self.view.frame.size;
    self.nextButton.frame = CGRectMake(size.width / 2.0 - 25, size.height / 2.0 - 25, 50, 50);
}

- (UIEdgeInsets)hb_contenteEdges {
    
    return UIEdgeInsetsMake(100, 0, 0, 0);
}

- (void)goNext {
    [self.class showCartPage:self];
}

@end
