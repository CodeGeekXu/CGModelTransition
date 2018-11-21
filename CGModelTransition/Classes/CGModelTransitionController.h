//
//  CGModelTransitionController.h
//  CGModelTransition
//
//  Created by 徐晨光 on 2018/11/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Model transition animation style.
 */
typedef NS_ENUM(NSInteger,CGTransitionAnimation) {
    CGTransitionAnimationZoomCenter,
    CGTransitionAnimationSlideFromTop,
    CGTransitionAnimationSlideFromBottom,
};

@interface CGModelTransitionController : UIPresentationController

// default CGTransitionAnimationZoomCenter
@property (nonatomic, assign) CGTransitionAnimation transitionAnimation;

// default 0.5s
@property (nonatomic, assign) CGFloat animateDuration;

// default CGSizeMake(300, 200)
@property (nonatomic, assign) CGSize presentedContentSize;

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController;

@end

NS_ASSUME_NONNULL_END
