//
//  CGDatePickerController.m
//  CGModelTransition_Example
//
//  Created by 徐晨光 on 2018/11/21.
//  Copyright © 2018年 codegeekxu@gmail.com. All rights reserved.
//

#import "CGDatePickerController.h"
#import <CGModelTransition/CGModelTransition.h>

@interface CGDatePickerController ()

@end

@implementation CGDatePickerController

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGModelTransitionController *transition = [[CGModelTransitionController alloc]initWithPresentedViewController:self];
        transition.presentedContentSize = CGSizeMake(UIScreen.mainScreen.bounds.size.width, 266);;
        transition.transitionAnimation = CGTransitionAnimationSlideFromBottom;
        self.modelTransition = transition;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)dismissPicker:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
