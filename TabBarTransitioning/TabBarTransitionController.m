//
//  TabBarTransitionController.m
//  TabBarTransitioning
//
//  Created by Daniel Garbień on 29/10/14.
//  Copyright (c) 2014 Daniel Garbien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarTransitionController.h"
#import "TabBarControllerDelegate.h"
//#import "UITabBarController+SafeIndexSelection.h"


@interface TabBarTransitionController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) TabBarControllerDelegate * tabBarControllerDelegate;
@property (weak, nonatomic) UITabBarController * tabBarController;
@property (strong, nonatomic) UIPanGestureRecognizer * panGestureRecognizer;
@property (assign, nonatomic) BOOL userPansRight;

@end

@implementation TabBarTransitionController

- (instancetype)initWithTabBarController:(UITabBarController *)tabBarController tabBarControllerDelegate:(TabBarControllerDelegate *)tabBarControllerDelegate
{
    self = [super init];
    if (self) {
        NSString * assertMessage = @"Provided tabBarControllerDelegate MUST be a delegate of tabBarController.";
        NSAssert(tabBarController.delegate != nil, assertMessage);
        NSAssert(tabBarController.delegate == tabBarControllerDelegate, assertMessage);
        
        _tabBarController = tabBarController;
        _tabBarControllerDelegate = tabBarControllerDelegate;
        
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(userDidPan:)];
        _panGestureRecognizer.delegate = self;
        [_tabBarController.view addGestureRecognizer:_panGestureRecognizer];
    }
    return self;
}

#pragma mark - Private Methods (UIPanGestureRecognizer)

- (void)userDidPan:(UIPanGestureRecognizer *)sender
{
    CGPoint translation = [sender translationInView:self.tabBarController.view];
    CGPoint velocity = [sender velocityInView:self.tabBarController.view];
    CGFloat ratio = translation.x / CGRectGetWidth(sender.view.bounds);
    if (self.userPansRight == NO) {
        ratio *= -1;
    }
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSInteger newSelectedIndex = self.tabBarController.selectedIndex;
        newSelectedIndex += self.userPansRight ? -1 : +1;
        
        self.tabBarControllerDelegate.interactive = YES;
//        [self.tabBarController beginSelectingIndexSafely:newSelectedIndex];
        self.tabBarController.selectedIndex = newSelectedIndex;
        return;
    }
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        [self.tabBarControllerDelegate.interactiveTransition updateInteractiveTransition:ratio];
        return;
    }
    
    if (sender.state == UIGestureRecognizerStateCancelled) {
        [self cancelInteractiveTransitionWithRatio:ratio];
        return;
    }
    
    if (sender.state == UIGestureRecognizerStateFailed) {
        [self cancelInteractiveTransitionWithRatio:ratio];
        return;
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
//        if (self.tabBarControllerDelegate.isAnimating) {
            [self completeInteractiveTransitionWithVelocity:velocity ratio:ratio];
//        } else {
//            [self.tabBarControllerDelegate cancelNextTransitionAfterStart];
//            self.tabBarControllerDelegate.interactive = NO;
//        }
    }
}

- (void)completeInteractiveTransitionWithVelocity:(CGPoint)velocity ratio:(CGFloat)ratio
{
    if ((self.userPansRight && velocity.x > 0)
        || (self.userPansRight == NO && velocity.x < 0)) {
        self.tabBarControllerDelegate.interactiveTransition.completionSpeed = 1 - ratio;
        [self.tabBarControllerDelegate.interactiveTransition finishInteractiveTransition];
    }
    else{
        self.tabBarControllerDelegate.interactiveTransition.completionSpeed = ratio > 0 ? ratio : 1; // completionSpeed == 0 might block the UI
        [self.tabBarControllerDelegate.interactiveTransition cancelInteractiveTransition];
    }
    self.tabBarControllerDelegate.interactive = NO;
}

- (void)cancelInteractiveTransitionWithRatio:(CGFloat)ratio
{
//    if (self.tabBarControllerDelegate.isAnimating) {
        self.tabBarControllerDelegate.interactiveTransition.completionSpeed = ratio > 0 ? ratio : 1; // completionSpeed == 0 might block the UI
        [self.tabBarControllerDelegate.interactiveTransition cancelInteractiveTransition];
//    } else {
//        [self.tabBarControllerDelegate cancelNextTransitionAfterStart];
//    }
    self.tabBarControllerDelegate.interactive = NO;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint velocity = [gestureRecognizer velocityInView:gestureRecognizer.view];
    
    // accept only horizontal gestures
    if (fabs(velocity.x) < fabs(velocity.y)) {
        return NO;
    }
    
    self.userPansRight = velocity.x > 0;
    
    if (self.userPansRight
        && self.tabBarController.selectedIndex == 0) {
        return NO;
    }
    
    if (self.userPansRight == NO
        && self.tabBarController.selectedIndex == ([self.tabBarController.viewControllers count] - 1)) {
        return NO;
    }
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

@end
