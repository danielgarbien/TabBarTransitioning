//
//  TabBarControllerDelegate.m
//  TabBarTransitioning
//
//  Created by Daniel Garbień on 29/10/14.
//  Copyright (c) 2014 Daniel Garbien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarControllerDelegate.h"
#import "AbstractTransition.h"

@interface TabBarControllerDelegate ()

@property (strong, nonatomic, readwrite) UIPercentDrivenInteractiveTransition * interactiveTransition;
@property (strong, nonatomic) AbstractTransition * noninteractiveTransition;

@end

@implementation TabBarControllerDelegate

#pragma mark - Public Methods

- (instancetype)initWithAnimator:(AbstractTransition *)animator
{
    self = [super init];
    if (self) {
        _noninteractiveTransition = animator;
    }
    return self;
}

- (BOOL)isAnimating
{
    return self.noninteractiveTransition.isAnimating;
}

//- (void)cancelNextTransitionAfterStart
//{
//    [self.noninteractiveTransition cancelTransitionAfterStart];
//}

#pragma mark - UITabBarControllerDelegate

- (id <UIViewControllerInteractiveTransitioning>)tabBarController:(UITabBarController *)tabBarController
                      interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController NS_AVAILABLE_IOS(7_0)
{
    return self.interactive ? self.interactiveTransition : nil;
}

- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController
            animationControllerForTransitionFromViewController:(UIViewController *)fromVC
                                              toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    NSInteger fromVCIndex = [tabBarController.viewControllers indexOfObject:fromVC];
    NSInteger toVCIndex = [tabBarController.viewControllers indexOfObject:toVC];
    
    self.noninteractiveTransition.presenting = fromVCIndex < toVCIndex;
    
    return self.noninteractiveTransition;
}

#pragma mark - Private Properties

- (UIPercentDrivenInteractiveTransition *)interactiveTransition
{
    if (_interactiveTransition == nil) {
        _interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
    }
    return _interactiveTransition;
}

@end