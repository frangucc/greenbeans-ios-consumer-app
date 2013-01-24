//
//  BeansTabBarController.m
//  ConsumerGB
//
//  Created by Srikanth on 1/16/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import "BeansTabBarController.h"
#import "HomeBeansViewController.h"

@interface BeansTabBarController ()

@end

@implementation BeansTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutSuccess:) name:LOGOUT_SUCCESS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logoutFailure:) name:LOGOUT_FAILURE_NOTIFICATION object:nil];

    // Customize tabbar
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_bg_center.png"]];
    [self.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"tabbar_item_selected.png"]];
    
    UIImage *icon1 = [UIImage imageNamed:@"icon1.png"];
    UITabBarItem *firstTabItem = [self.tabBar.items objectAtIndex:0];
    [firstTabItem setFinishedSelectedImage:icon1 withFinishedUnselectedImage:icon1];

    UIImage *icon2 = [UIImage imageNamed:@"icon2.png"];
    UITabBarItem *secondTabItem = [self.tabBar.items objectAtIndex:1];
    [secondTabItem setFinishedSelectedImage:icon2 withFinishedUnselectedImage:icon2];

    UIImage *icon3 = [UIImage imageNamed:@"icon3.png"];
    UITabBarItem *thirdTabItem = [self.tabBar.items objectAtIndex:3];
    [thirdTabItem setFinishedSelectedImage:icon3 withFinishedUnselectedImage:icon3];

    UIImage *icon4 = [UIImage imageNamed:@"icon4.png"];
    UITabBarItem *fourthTabItem = [self.tabBar.items objectAtIndex:4];
    [fourthTabItem setFinishedSelectedImage:icon4 withFinishedUnselectedImage:icon4];
}


- (void)doLogout
{
    NSLog(@"BeansTabBarController - doLogout");
    
    // MBProgressHUD start
    [[APIService getService] startHUD:self.view];

    [[APIService getService] logout];
}

- (void)logoutSuccess:(NSNotification *)notification
{
    NSLog(@" logoutSuccess: %@", notification.object);

    // MBProgressHUD stop
    [[APIService getService] stopHUD:self.view];

    if (200 == [[notification.object objectForKey:@"status"] intValue]) {
        // Reset currently logged-in user, so user needs to log in again
        [[APIService getService] setUser:[[NSMutableDictionary alloc] init]];
        // Back to Claim Beans screen
        HomeBeansViewController *homeBeansVC = (HomeBeansViewController*) [self.navigationController.viewControllers objectAtIndex:1];
        [self.navigationController popToViewController:homeBeansVC animated:YES];
    }
}

- (void)logoutFailure:(NSNotification *)notification
{
    NSLog(@" logoutFailure");

    // MBProgressHUD stop
    [[APIService getService] stopHUD:self.view];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
