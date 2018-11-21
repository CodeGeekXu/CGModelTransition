//
//  CGTopViewController.m
//  CGModelTransition_Example
//
//  Created by 徐晨光 on 2018/11/21.
//  Copyright © 2018年 codegeekxu@gmail.com. All rights reserved.
//

#import "CGTopViewController.h"
#import <CGModelTransition/CGModelTransition.h>

@interface CGTopViewController ()

@end

@implementation CGTopViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGModelTransitionController *transition = [[CGModelTransitionController alloc]initWithPresentedViewController:self];
        transition.presentedContentSize = CGSizeMake(275, 230);;
        transition.transitionAnimation = CGTransitionAnimationSlideFromTop;
        transition.animateDuration = 1;
        self.modelTransition = transition;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
    self.view.backgroundColor = [UIColor redColor];
}

@end
