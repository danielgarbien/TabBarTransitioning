//
//  TabBarTransitionController.h
//  TabBarTransitioning
//
//  Created by Daniel Garbień on 29/10/14.
//  Copyright (c) 2014 Daniel Garbien. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TabBarControllerDelegate;

/**
 * Adds gesture recognizer to tabBarController's view and handles it to change tabs and drive interactive transition.
 */
@interface TabBarTransitionController : NSObject

/**
 * Provided tabBarControllerDelegate MUST be set as a tabBarController's delegate before calling this method.
 * 
 * @param tabBarController Stored with weak reference.
 * @param tabBarControllerDelegate Stored with weak reference.
 * @return Instance of TabBarTransitionController.
 */
- (instancetype)initWithTabBarController:(UITabBarController *)tabBarController tabBarControllerDelegate:(TabBarControllerDelegate *)tabBarControllerDelegate;

@end
