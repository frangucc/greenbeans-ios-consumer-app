//
//  ViewController.m
//  ConsumerGB
//
//  Created by Srikanth on 1/14/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Home pattern image
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"home_pattern.png"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setPlayBeansBtn:nil];
    [super viewDidUnload];
}
@end
