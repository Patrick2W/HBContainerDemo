//
//  HBCartViewController.m
//  HBContainerDemo
//
//  Created by cheyun on 2018/12/28.
//  Copyright © 2018 Patrick. All rights reserved.
//

#import "HBCartViewController.h"
#import "HBContainer.h"

@interface HBCartViewController ()

@property (strong, nonatomic) UIView *infoView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *priceLabel;
@property (strong, nonatomic) UILabel *numberLabel;
@property (strong, nonatomic) UILabel *colorLabel;

@property (strong, nonatomic) UIScrollView *contentView;
@property (strong, nonatomic) UILabel *colorTitleLabel;

@property (strong, nonatomic) UIButton *button;

@property (assign, nonatomic) BOOL pulled;

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.infoView = [[UIView alloc] init];
    self.imageView = [[UIImageView alloc] init];
    self.priceLabel = [[UILabel alloc] init];
    self.numberLabel = [[UILabel alloc] init];
    self.colorLabel = [[UILabel alloc] init];
    [self.infoView addSubview:self.imageView];
    [self.infoView addSubview:self.priceLabel];
    [self.infoView addSubview:self.numberLabel];
    
    self.contentView = [[UIScrollView alloc] init];
    self.colorTitleLabel = [[UILabel alloc] init];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setBackgroundColor:[UIColor yellowColor]];
    
    [self.view addSubview:self.infoView];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.button];
    
    self.infoView.backgroundColor = [UIColor blueColor];
    self.contentView.backgroundColor = [UIColor orangeColor];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self updateFrame];
}

- (void)updateFrame {
    
    CGFloat infoHeight = 80;
    CGSize mainSize = self.view.frame.size;
    self.infoView.frame = CGRectMake(0, 0, mainSize.width, infoHeight);
    self.button.frame = CGRectMake(10, mainSize.height - 55, mainSize.width - 20, 45);
    
    CGFloat contentH = self.button.frame.origin.y - infoHeight;
    self.contentView.frame = CGRectMake(0, infoHeight, mainSize.width, contentH);
}

//- (CGSize)hb_contentSize {
//    CGSize mainSize = [UIScreen mainScreen].bounds.size;
//    return CGSizeMake(mainSize.width, 400);
//}

- (UIEdgeInsets)hb_contenteEdges {
    CGSize mainSize = [UIScreen mainScreen].bounds.size;
    return UIEdgeInsetsMake(mainSize.height - 450, 0, 0, 0);
}

@end
