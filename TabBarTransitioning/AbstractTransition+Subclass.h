//
//  AbstractTransition+Subclass.h
//  TabBarTransitioning
//
//  Created by Daniel Garbień on 29/10/14.
//  Copyright (c) 2014 Daniel Garbien. All rights reserved.
//

#import "AbstractTransition.h"

@interface AbstractTransition (Subclass)

/**
 * This flag should be checked at the begining of animateTransition: subclass implementation.
 * If yes the transition should be completed as cancelled. ([transitionContext completeTransition:NO]);
 */
@property (assign, nonatomic) BOOL shouldCancelTransitionAfterStart;

/**
 * Call this method from at the end of animateTransition: implementation from within AbstratctTransition subclass.
 * Do not override.
 */
//- (void)animateTransitionDidStart;

@end
