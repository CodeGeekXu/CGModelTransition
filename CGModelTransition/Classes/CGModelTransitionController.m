//
//  CGModelTransitionController.m
//  CGModelTransition
//
//  Created by 徐晨光 on 2018/11/21.
//

#import "CGModelTransitionController.h"

@interface CGModelTransitionController ()<
UIViewControllerTransitioningDelegate,
UIViewControllerAnimatedTransitioning
>

/** 黑色半透明背景 */
@property (nonatomic, strong) UIView *dimmingView;

@end

@implementation CGModelTransitionController

#pragma mark - Override

- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController
{
    self = [super initWithPresentedViewController:presentedViewController presentingViewController:nil];
    
    if (self) {
        // 必须设置 presentedViewController 的 modalPresentationStyle
        // 在自定义动画效果的情况下，苹果强烈建议设置为 UIModalPresentationCustom
        self.animateDuration = 0.5;
        presentedViewController.modalPresentationStyle = UIModalPresentationCustom;
        presentedViewController.transitioningDelegate = self;
        self.presentedContentSize = CGSizeMake(300, 200);
    }
    
    return self;
}

// 呈现过渡即将开始的时候被调用的
// 可以在此方法创建和设置自定义动画所需的view

- (void)presentationTransitionWillBegin
{
    // 背景遮罩
    UIView *dimmingView = [[UIView alloc] initWithFrame:self.containerView.bounds];
    dimmingView.backgroundColor = [UIColor blackColor];
    dimmingView.opaque = NO; //是否透明
    dimmingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [dimmingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dimmingViewTapped:)]];
    self.dimmingView = dimmingView;
    
    [self.containerView addSubview:dimmingView]; // 添加到动画容器View中。
    
    // 获取presentingViewController 的转换协调器，应该动画期间的一个类？上下文？之类的，负责动画的一个东西
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    // 动画期间，背景View的动画方式
    self.dimmingView.alpha = 0.f;
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.4f;
    } completion:NULL];
}

// 在呈现过渡结束时被调用的，并且该方法提供一个布尔变量来判断过渡效果是否完成
- (void)presentationTransitionDidEnd:(BOOL)completed
{
    // 在取消动画的情况下，可能为NO，这种情况下，应该取消视图的引用，防止视图没有释放
    if (!completed)
    {
        self.dimmingView = nil;
    }
}

// 消失过渡即将开始的时候被调用的
- (void)dismissalTransitionWillBegin
{
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = self.presentingViewController.transitionCoordinator;
    
    [transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.dimmingView.alpha = 0.f;
    } completion:NULL];
}

// 消失过渡完成之后调用，此时应该将视图移除，防止强引用
- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed == YES)
    {
        [self.dimmingView removeFromSuperview];
        self.dimmingView = nil;
    }
}

// 是控制器内容大小变化时，就会调用这个方法， 比如适配横竖屏幕时，翻转屏幕时
- (void)preferredContentSizeDidChangeForChildContentContainer:(id<UIContentContainer>)container
{
    [super preferredContentSizeDidChangeForChildContentContainer:container];
    
    if (container == self.presentedViewController)
        [self.containerView setNeedsLayout];
}

- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
    self.dimmingView.frame = self.containerView.bounds;
}

#pragma mark event response

- (void)dimmingViewTapped:(UITapGestureRecognizer*)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UIViewControllerTransitioningDelegate

// 来告诉控制器，谁是动画主管(UIPresentationController)
- (UIPresentationController* )presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return self;
}

// 返回的对象控制Presented时的动画 (开始动画的具体细节负责类)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}
// 由返回的控制器控制dismissed时的动画 (结束动画的具体细节负责类)
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning

// 动画时长
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return [transitionContext isAnimated] ? self.animateDuration : 0;
}

// 核心，动画效果的实现
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // 1.获取源控制器、目标控制器、动画容器View
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    CGRect toViewFrame = CGRectZero;
    toViewFrame.size = self.presentedContentSize;
    toView.frame = toViewFrame;
    
    UIView *containerView = transitionContext.containerView;
    [containerView addSubview:toView];  //必须添加到动画容器View上。
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    // 判断是present 还是 dismiss
    CGFloat screenW = CGRectGetWidth(containerView.bounds);
    CGFloat screenH = CGRectGetHeight(containerView.bounds);
    
    BOOL isPresenting = (fromViewController == self.presentingViewController);
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    if (self.transitionAnimation == CGTransitionAnimationSlideFromTop) {
        
        CGPoint topPoint = CGPointMake(screenW/2, -screenH/2);
        CGPoint centerPoint = CGPointMake(screenW/2, screenH/2);
        CGPoint bottomPoint = CGPointMake(screenW/2, screenH*1.5 + 10);
        
        if (isPresenting) {
            toView.center = topPoint;
        }
        
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:0.3f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (isPresenting)
                toView.center = centerPoint;
            else
                fromView.center = bottomPoint;
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    }else if(self.transitionAnimation == CGTransitionAnimationZoomCenter){
        
        CGPoint centerPoint = CGPointMake(screenW/2, screenH/2);
        
        if (isPresenting) {
            toView.center = centerPoint;
            toView.transform = CGAffineTransformMakeScale(0, 0);
        }
        
        [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:0.3f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (isPresenting)
                toView.transform = CGAffineTransformMakeScale(1, 1);
            else
                fromView.transform = CGAffineTransformMakeScale(0, 0);
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    }else{
        CGPoint topPoint = CGPointMake(screenW/2, screenH-self.presentedContentSize.height/2);
        CGPoint bottomPoint = CGPointMake(screenW/2, screenH+self.presentedContentSize.height/2);
        
        if (isPresenting) {
            toView.center = bottomPoint;
        }
        
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (isPresenting)
                toView.center = topPoint;
            else
                fromView.center = bottomPoint;
        } completion:^(BOOL finished) {
            BOOL wasCancelled = [transitionContext transitionWasCancelled];
            [transitionContext completeTransition:!wasCancelled];
        }];
    }
}

- (void)animationEnded:(BOOL) transitionCompleted
{
    // 动画结束...
}


@end
