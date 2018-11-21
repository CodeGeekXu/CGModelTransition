//
//  UIViewController+CGModelTransition.m
//  CGModelTransition
//
//  Created by 徐晨光 on 2018/11/21.
//

#import "UIViewController+CGModelTransition.h"

static void *CGModelTransitionKey = "CGModelTransitionKey";

@implementation UIViewController (CGModelTransition)

- (void)setModelTransition:(CGModelTransitionController *)modelTransition
{
    objc_setAssociatedObject(self, CGModelTransitionKey, modelTransition, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGModelTransitionController *)modelTransition
{
    return objc_getAssociatedObject(self, CGModelTransitionKey);
}

@end
