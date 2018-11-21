//
//  UIViewController+CGModelTransition.h
//  CGModelTransition
//
//  Created by 徐晨光 on 2018/11/21.
//

#import <UIKit/UIKit.h>
#import "CGModelTransitionController.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CGModelTransition)

@property (nonatomic, strong) CGModelTransitionController *modelTransition;

@end

NS_ASSUME_NONNULL_END
