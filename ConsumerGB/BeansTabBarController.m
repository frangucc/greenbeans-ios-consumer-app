//
//  BeansTabBarController.m
//  ConsumerGB
//
//  Created by Srikanth on 1/16/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import "BeansTabBarController.h"

@interface BeansTabBarController ()

@end

@implementation BeansTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
