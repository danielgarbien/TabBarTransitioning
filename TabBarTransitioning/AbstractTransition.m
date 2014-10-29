//
//  AbstractTransition.m
//  TabBarTransitioning
//
//  Created by Daniel Garbień on 29/10/14.
//  Copyright (c) 2014 Daniel Garbien. All rights reserved.
//

#import "AbstractTransition.h"

NSTimeInterval const kDuration = 0.3;

@interface AbstractTransition ()

@property (assign, nonatomic) BOOL shouldCancelTransitionAfterStart;

@end

@implementation AbstractTransition

#pragma mark - Public Methods

//- (void)cancelTransitionAfterStart
//{
//    self.shouldCancelTransitionAfterStart = YES;
//}

#pragma mark - UIViewControllerAnimatedTransitioning

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return kDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    NSAssert(NO, @"AbstractTransition  shall not be used by itself by subclassed instead");
}

- (void)animationEnded:(BOOL)transitionCompleted
{
    self.animating = NO;
//    self.shouldCancelTransitionAfterStart = NO;
    [self.delegate transition:self didComplete:transitionCompleted];
}

#pragma mark - Private Methods for subclass use

- (void)animateTransitionDidStart
{
    self.animating = YES;
}

@end
