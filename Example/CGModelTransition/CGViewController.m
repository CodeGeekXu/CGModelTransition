//
//  CGViewController.m
//  CGModelTransition
//
//  Created by codegeekxu@gmail.com on 11/21/2018.
//  Copyright (c) 2018 codegeekxu@gmail.com. All rights reserved.
//

#import "CGViewController.h"
#import "CGDatePickerController.h"
#import "CGAlertController.h"
#import "CGTopViewController.h"

@interface CGViewController ()

@end

@implementation CGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapDatePickerButton:(id)sender {
    CGDatePickerController *datePicker = [CGDatePickerController new];
    [self presentViewController:datePicker animated:YES completion:nil];
}

- (IBAction)didTapAlertControllerButton:(id)sender {
    CGAlertController *alertController = [CGAlertController new];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)didTapTopButton:(id)sender {
    CGTopViewController *vc = [CGTopViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
