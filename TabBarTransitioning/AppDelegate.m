//
//  AppDelegate.m
//  TabBarTransitioning
//
//  Created by Daniel Garbień on 29/10/14.
//  Copyright (c) 2014 Daniel Garbien. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarTransitionController.h"
#import "TabBarControllerDelegate.h"
#import "ScrollTransition.h"

@interface AppDelegate ()

@property (weak, nonatomic) UITabBarController * tabBarController;
@property (strong, nonatomic) TabBarTransitionController * tabBarTransitionController;
@property (strong, nonatomic) TabBarControllerDelegate * tabBarControllerDelegate;

@end

@implementation AppDelegate

#pragma mark - Private Properties

- (UITabBarController *)tabBarController
{
    return (UITabBarController *)self.window.rootViewController;
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    AbstractTransition * animator = [[ScrollTransition alloc] init];
    
    self.tabBarControllerDelegate = [[TabBarControllerDelegate alloc] initWithAnimator:animator];
    self.tabBarController.delegate = self.tabBarControllerDelegate;
    
    self.tabBarTransitionController = [[TabBarTransitionController alloc] initWithTabBarController:self.tabBarController
                                                                          tabBarControllerDelegate:self.tabBarControllerDelegate];
    
    return YES;
}

@end
