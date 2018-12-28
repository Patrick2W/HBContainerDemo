//
//  HBRedPacketViewController.m
//  HBContainerDemo
//
//  Created by cheyun on 2018/12/28.
//  Copyright © 2018 Patrick. All rights reserved.
//

#import "HBRedPacketViewController.h"
#import "HBContainer.h"

@interface HBRedPacketViewController ()

@property (strong, nonatomic) UIImageView *redPacketView;
@property (strong, nonatomic) UIButton *closeButton;

@end

@implementation HBRedPacketViewController

+ (HBRedPacketViewController *)showRedPacketPage:(UIViewController *)caller {
    HBRedPacketViewController *vc = [[HBRedPacketViewController alloc] init];
    HBContainerController *container = [[HBContainerController alloc] initWithRootViewController:vc];
    [container setPresentAnimationStyle:HBContainerPresentAnimationStyleTopIn
                  dismissAnimationStyle:HBContainerDismissAnimationStyleRightOut];
    [caller presentViewController:container animated:YES completion:nil];
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.redPacketView];
    [self.view addSubview:self.closeButton];
    [self.closeButton addTarget:self
                         action:@selector(closeCurrentPage)
               forControlEvents:UIControlEventTouchUpInside];
}

- (CGSize)hb_contentSize {
    return CGSizeMake(186.5, 310);
}

- (CGPoint)hb_centerOffSet {
    
    return CGPointMake(0, -20);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGSize contentSize = self.view.frame.size;
    self.redPacketView.frame = CGRectMake(0, 11, contentSize.width, contentSize.height - 11);
    self.closeButton.frame = CGRectMake(contentSize.width - 35, 0, 35, 35);
}

- (void)closeCurrentPage {
    
    [self.containerController dismissViewControllerAnimated:YES completion:nil];
}

- (UIImageView *)redPacketView {
    if (!_redPacketView) {
        _redPacketView = [[UIImageView alloc] init];
        _redPacketView.image = [UIImage imageNamed:@"red_packet"];
    }
    return _redPacketView;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"close"]
                      forState:UIControlStateNormal];
    }
    return _closeButton;
}

@end
