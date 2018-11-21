//
//  CGAlertController.m
//  CGModelTransition_Example
//
//  Created by 徐晨光 on 2018/11/21.
//  Copyright © 2018年 codegeekxu@gmail.com. All rights reserved.
//

#import "CGAlertController.h"
#import <CGModelTransition/CGModelTransition.h>

@interface CGAlertController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation CGAlertController

- (instancetype)init
{
    self = [super init];
    if (self) {
        CGModelTransitionController *transition = [[CGModelTransitionController alloc]initWithPresentedViewController:self];
        transition.presentedContentSize = CGSizeMake(275, 230);;
        transition.transitionAnimation = CGTransitionAnimationZoomCenter;
        self.modelTransition = transition;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.textView.layer.borderWidth = 1;
    self.textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.view.layer.cornerRadius = 10;
    self.view.layer.masksToBounds = YES;
}

- (IBAction)onSliderValueChanged:(UISlider *)sender {
    CGFloat offsetY = sender.value * self.textView.contentSize.height - CGRectGetHeight(self.textView.bounds);
    [self.textView setContentOffset:CGPointMake(0, offsetY > 0 ? offsetY : 0)];
}

- (IBAction)didTapDoneButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
