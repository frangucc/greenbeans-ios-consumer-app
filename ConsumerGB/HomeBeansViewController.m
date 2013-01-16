//
//  HomeBeansViewController.m
//  ConsumerGB
//
//  Created by Anh Viet on 1/16/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import "HomeBeansViewController.h"

@interface HomeBeansViewController ()

@end

@implementation HomeBeansViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

}

- (void)backBtnAction:(id)sender
{
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
