//
//  SettingsViewController.m
//  ConsumerGB
//
//  Created by Srikanth on 1/24/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import "SettingsViewController.h"
#import "BeansTabBarController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signoutAction:(id)sender
{
    // Do logout
    BeansTabBarController *beansTabBar = (BeansTabBarController*)self.tabBarController;
    [beansTabBar doLogout];
}

@end
