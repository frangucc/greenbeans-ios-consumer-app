//
//  HomeBeansViewController.m
//  ConsumerGB
//
//  Created by Srikanth on 1/16/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import "HomeBeansViewController.h"
#import "ActiveBeansCollectionViewController.h"
#import "BeansTabBarController.h"

@interface HomeBeansViewController ()

@end

@implementation HomeBeansViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Init
    _activeBeansVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ActiveBeansCollectionVC"];
    [self.view addSubview:_activeBeansVC.view];
    [self addChildViewController:_activeBeansVC];
    [_activeBeansVC.view setFrame:CGRectMake(12, 110, 296, 260)];

    // Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getConsumerBeansSuccess:) name:GET_CONSUMER_BEANS_SUCCESS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getConsumerBeansFailure:) name:GET_CONSUMER_BEANS_FAILURE_NOTIFICATION object:nil];
    
    // Customize Back button
    UIButton *backBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"back_btn.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setFrame:CGRectMake(0, 0, 59, 32)];
    UIView *backBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 59, 32)];
    backBtnView.bounds = CGRectOffset(backBtnView.bounds, 0, 0);   // trick is here !
    [backBtnView addSubview:backBtn];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtnView];
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:leftBtn, nil];

    // Add Star button
    UIButton *starBtn =  [UIButton buttonWithType:UIButtonTypeCustom];
    [starBtn setBackgroundImage:[UIImage imageNamed:@"star_btn.png"] forState:UIControlStateNormal];
    [starBtn addTarget:self action:@selector(starBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [starBtn setFrame:CGRectMake(0, 0, 43, 33)];
    UIView *starBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 43, 33)];
    starBtnView.bounds = CGRectOffset(backBtnView.bounds, -15, 0);
    [starBtnView addSubview:starBtn];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:starBtnView];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightBtn, nil];
    
    // Add point placeholder
    UIImageView *pointBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"point_bg.png"]];
    [pointBg setFrame:CGRectMake(261, 14, 18, 18)];
    [self.navigationController.navigationBar addSubview:pointBg];
    
    // Temporary only: set point values
    UILabel *starPoint = [[UILabel alloc] initWithFrame:CGRectMake(266, 13, 20, 20)];
    starPoint.backgroundColor = [UIColor clearColor];
    starPoint.shadowColor = [UIColor whiteColor];
    starPoint.shadowOffset = CGSizeMake(0, 1);
    starPoint.text = @"3";
    starPoint.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0];
    starPoint.textColor = RGBA(110, 114, 115, 1);
    [self.navigationController.navigationBar addSubview:starPoint];
    
    UILabel *tabbarPoint = [[UILabel alloc] initWithFrame:CGRectMake(170, -15, 20, 20)];
    tabbarPoint.backgroundColor = [UIColor clearColor];
    tabbarPoint.shadowColor = [UIColor whiteColor];
    tabbarPoint.shadowOffset = CGSizeMake(0, 1);
    tabbarPoint.text = @"3";
    tabbarPoint.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:12.0];
    tabbarPoint.textColor = RGBA(110, 114, 115, 1);
    [self.tabBarController.tabBar addSubview:tabbarPoint];
}

- (void)backBtnAction:(id)sender
{
    NSLog(@"Back");
    HomeBeansViewController *homeBeansVC = (HomeBeansViewController*) [self.tabBarController.navigationController.viewControllers objectAtIndex:1];
    [self.tabBarController.navigationController popToViewController:homeBeansVC animated:YES];
}

- (void)starBtnAction:(id)sender
{
    NSLog(@"starBtnAction");
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"HomeBeansViewController - viewWillAppear");
    [super viewWillAppear:animated];
    
    [self prepareData];
}

- (void)prepareData
{
    NSLog(@"HomeBeansViewController - prepareData");
    [[APIService getService] getConsumerBeans];
}

- (void)getConsumerBeansSuccess:(NSNotification *)notification
{
    NSLog(@" getConsumerBeansSuccess: %@", notification.object);
}

- (void)getConsumerBeansFailure:(NSNotification *)notification
{
    NSLog(@" getConsumerBeansFailure");
    if ([notification.object objectForKey:@"error"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authentication Failed" message:[notification.object objectForKey:@"error"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	NSString *tappedBtn = [alertView buttonTitleAtIndex:buttonIndex];
    NSLog(@"  tappedBtn: %@", tappedBtn);
    // Do logout
    BeansTabBarController *beansTabBar = (BeansTabBarController*)self.tabBarController;
    [beansTabBar doLogout];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
