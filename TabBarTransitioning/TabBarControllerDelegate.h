//
//  TabBarControllerDelegate.h
//  TabBarTransitioning
//
//  Created by Daniel Garbień on 29/10/14.
//  Copyright (c) 2014 Daniel Garbien. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AbstractTransition;

@interface TabBarControllerDelegate : NSObject <UITabBarControllerDelegate>

@property (assign, nonatomic) BOOL interactive;
@property (strong, nonatomic, readonly) UIPercentDrivenInteractiveTransition * interactiveTransition;

- (instancetype)initWithAnimator:(AbstractTransition *)animator;
//- (BOOL)isAnimating;
//- (void)cancelNextTransitionAfterStart;

@end
