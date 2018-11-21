# CGModelTransition

[![CI Status](https://img.shields.io/travis/codegeekxu@gmail.com/CGModelTransition.svg?style=flat)](https://travis-ci.org/codegeekxu@gmail.com/CGModelTransition)
[![Version](https://img.shields.io/cocoapods/v/CGModelTransition.svg?style=flat)](https://cocoapods.org/pods/CGModelTransition)
[![License](https://img.shields.io/cocoapods/l/CGModelTransition.svg?style=flat)](https://cocoapods.org/pods/CGModelTransition)
[![Platform](https://img.shields.io/cocoapods/p/CGModelTransition.svg?style=flat)](https://cocoapods.org/pods/CGModelTransition)

<p align="center"><img src="https://github.com/CodeGeekXu/CGModelTransition/blob/master/Example/CGModelTransition/CGModelTransition.gif"/></p>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
iOS >= 8.0
ARC

## Installation

CGModelTransition is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CGModelTransition'
```

## Usage

```objc
#import <CGModelTransition/CGModelTransition.h>

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

@end
```
```objc
    CGTopViewController *vc = [CGTopViewController new];
    [self presentViewController:vc animated:YES completion:nil];
```

## Author

codegeekxu@gmail.com, codegeekxu@gmail.com
