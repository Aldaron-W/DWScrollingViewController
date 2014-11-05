//
//  AppDelegate.m
//  DWScrollingViewController
//
//  Created by Private on 6/25/14.
//  Copyright (c) 2014 DrizzleWang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
            

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UITabBarController *tabBarView = [[UITabBarController alloc] init];
    
    //初始化所有的View
    ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    [contentViewController setTitle:@"第1页"];
    
    ContentViewController *contentViewController2 = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    [contentViewController2 setTitle:@"第2页第2页第2页第2页"];
    
    ContentViewController *contentViewController3 = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    [contentViewController3 setTitle:@"第3页"];
    
    ContentViewController *contentViewController4 = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    [contentViewController4 setTitle:@"第4页"];
    
    DWScrollingViewController *scrollingView = [[DWScrollingViewController alloc] initWithViewControllers:@[contentViewController, contentViewController2, contentViewController3, contentViewController4]];
    scrollingView.title = @"首页";
//    ViewController *view = [[ViewController alloc] init];
    
    //初始化所有的View
    ContentViewController *contentViewController11 = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    [contentViewController11 setTitle:@"第1页"];
    
    ContentViewController *contentViewController12 = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    [contentViewController12 setTitle:@"第2页"];
    
    ContentViewController *contentViewController13 = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    [contentViewController13 setTitle:@"第3页"];
    
    ContentViewController *contentViewController14 = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    [contentViewController14 setTitle:@"第4页"];
    
    DWScrollingViewController *scrollingView2 = [[DWScrollingViewController alloc] initWithViewControllers:@[contentViewController11, contentViewController12, contentViewController13, contentViewController14]];
    scrollingView2.title = @"设置";
    
    [tabBarView setViewControllers:@[scrollingView, scrollingView2]];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tabBarView];
    self.window.backgroundColor = [UIColor whiteColor];
    //    self.window.tintColor = COLOR_TINT;
    [self.window setRootViewController:navigationController];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
