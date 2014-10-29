//
//  AbstractTransition.h
//  TabBarTransitioning
//
//  Created by Daniel Garbień on 29/10/14.
//  Copyright (c) 2014 Daniel Garbien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSTimeInterval const kDuration;

@class AbstractTransition;

@protocol TransitionDelegate <NSObject>

- (void)transition:(AbstractTransition *)transition didComplete:(BOOL)didComplete;

@end

@interface AbstractTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) BOOL presenting;
//@property (assign, nonatomic, getter=isAnimating) BOOL animating;
@property (weak, nonatomic) id<TransitionDelegate> delegate; // Subclass implementation is responsible for sending messages to delegate

//- (void)cancelTransitionAfterStart;

@end
