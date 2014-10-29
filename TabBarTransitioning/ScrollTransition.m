//
//  ScrollTransition.m
//  TabBarTransitioning
//
//  Created by Daniel Garbień on 29/10/14.
//  Copyright (c) 2014 Daniel Garbien. All rights reserved.
//

#import "ScrollTransition.h"
#import "AbstractTransition+Subclass.h"

@implementation ScrollTransition

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    if (self.shouldCancelTransitionAfterStart) {
        [transitionContext completeTransition:NO];
        return;
    }
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect endFrame = [[transitionContext containerView] bounds];
    
    if (self.presenting) {
        [transitionContext.containerView insertSubview:toViewController.view belowSubview:fromViewController.view]; // fromView is already in containerView
        
        CGRect startFrame = endFrame;
        startFrame.origin.x += CGRectGetWidth(([[transitionContext containerView] bounds]));
        toViewController.view.frame = startFrame;
        
        CGRect endFrameFromView = endFrame;
        endFrameFromView.origin.x -= CGRectGetWidth(([[transitionContext containerView] bounds]));
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             toViewController.view.frame = endFrame;
                             fromViewController.view.frame = endFrameFromView;
                         } completion:^(BOOL finished) {
                             BOOL didComplete = [transitionContext transitionWasCancelled] == NO;
                             [transitionContext completeTransition:didComplete];
                         }];
    }
    else {
        [transitionContext.containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
        
        CGRect startFrameToView = endFrame;
        startFrameToView.origin.x -= CGRectGetWidth([[transitionContext containerView] bounds]);
        toViewController.view.frame = startFrameToView;
        
        CGRect endFrameFromView = endFrame;
        endFrameFromView.origin.x += CGRectGetWidth(([[transitionContext containerView] bounds]));
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext]
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             fromViewController.view.frame = endFrameFromView;
                             toViewController.view.frame = endFrame;
                         } completion:^(BOOL finished) {
                             BOOL didComplete = [transitionContext transitionWasCancelled] == NO;
                             [transitionContext completeTransition:didComplete];
                         }];
    }
    
    [self animateTransitionDidStart];
}

@end
