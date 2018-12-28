//
//  UIViewController+HBAdd.h
//  HBContainer
//
//  Created by cheyun on 2018/7/23.
//  Copyright © 2018年 Patrick. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HBContainerController;
@interface UIViewController (HBAdd)

/**
 *  设置UIViewController的view的size
 *  offset 偏移量
 *  与setEdges:二选一
 */
- (void)setSize:(CGSize)size centerOffSet:(CGPoint)offSet;

/**
 *  设置UIViewController的view的边距
 */
- (void)setEdges:(UIEdgeInsets)edges;

- (CGSize)hb_contentSize;
- (CGPoint)hb_centerOffSet;
- (UIEdgeInsets)hb_contenteEdges;

@property (nullable, weak , nonatomic) HBContainerController *containerController;

@end

