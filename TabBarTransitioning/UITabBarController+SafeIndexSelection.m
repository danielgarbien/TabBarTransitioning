//
//  UITabBarController+SafeIndexSelection.m
//  TabBarTransitioning
//
//  Created by Daniel Garbień on 29/10/14.
//  Copyright (c) 2014 Daniel Garbien. All rights reserved.
//

#import "UITabBarController+SafeIndexSelection.h"
#import "TabBarControllerDelegate.h"

#import <objc/runtime.h>

static void * const kSelectingKey = (void *)&kSelectingKey;


@interface UITabBarController ()

@property (assign, nonatomic, getter=isSelecting) BOOL selecting;

@end


@implementation UITabBarController (SafeIndexSelection)

- (void)beginSelectingIndexSafely:(NSUInteger)selectedIndex
{
    UIViewController * selectedViewController = self.viewControllers[selectedIndex];
    [self beginSelectingViewControllerSafely:selectedViewController];
}

- (void)beginSelectingViewControllerSafely:(UIViewController *)selectedViewController
{
    if (self.isSelecting) {
        return;
    }
    
    self.selecting = YES;
    self.selectedViewController = selectedViewController;
}

- (void)endSelectingSafely
{
    self.selecting = NO;
}

#pragma mark - Private Properties

- (void)setSelecting:(BOOL)selecting
{
    objc_setAssociatedObject(self,
                             kSelectingKey,
                             @(selecting),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isSelecting
{
    NSNumber * boolNumber = objc_getAssociatedObject(self, kSelectingKey);
    return [boolNumber boolValue];
}

@end
