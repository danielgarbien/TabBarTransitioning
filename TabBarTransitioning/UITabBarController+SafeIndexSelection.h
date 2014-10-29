//
//  UITabBarController+SafeIndexSelection.h
//  TabBarTransitioning
//
//  Created by Daniel Garbień on 29/10/14.
//  Copyright (c) 2014 Daniel Garbien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (SafeIndexSelection)

- (void)beginSelectingIndexSafely:(NSUInteger)selectedIndex;
- (void)beginSelectingViewControllerSafely:(UIViewController *)selectedViewController;
- (void)endSelectingSafely;

@end
