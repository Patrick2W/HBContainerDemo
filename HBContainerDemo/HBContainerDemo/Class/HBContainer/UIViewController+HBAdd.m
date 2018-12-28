//
//  UIViewController+HBAdd.m
//  HBContainer
//
//  Created by cheyun on 2018/7/23.
//  Copyright © 2018年 Patrick. All rights reserved.
//

#import "UIViewController+HBAdd.h"
#import "HBContainerController.h"
#import <objc/runtime.h>

@implementation UIViewController (HBAdd)

- (void)setSize:(CGSize)size centerOffSet:(CGPoint)offSet {
    
    objc_setAssociatedObject(self, @selector(hb_contentSize), [NSValue valueWithCGSize:size], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @selector(hb_centerOffSet), [NSValue valueWithCGPoint:offSet], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setEdges:(UIEdgeInsets)edges {
    objc_setAssociatedObject(self, @selector(hb_contenteEdges), [NSValue valueWithUIEdgeInsets:edges], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)hb_contentSize {
    
    return [objc_getAssociatedObject(self, @selector(hb_contentSize)) CGSizeValue];
}

- (CGPoint)hb_centerOffSet {
    
    return [objc_getAssociatedObject(self, @selector(hb_centerOffSet)) CGPointValue];
}

- (UIEdgeInsets)hb_contenteEdges {
    
    return [objc_getAssociatedObject(self, @selector(hb_contenteEdges)) UIEdgeInsetsValue];;
}

- (void)setContainerController:(HBContainerController *)containerController {
    
    objc_setAssociatedObject(self, @selector(containerController), containerController, OBJC_ASSOCIATION_ASSIGN);
}

- (HBContainerController *)containerController {
    
    return objc_getAssociatedObject(self, @selector(containerController));
}

@end

