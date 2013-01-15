//
//  ClaimBeansViewController.m
//  ConsumerGB
//
//  Created by Srikanth on 1/15/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import "ClaimBeansViewController.h"

@interface ClaimBeansViewController ()

@end

@implementation ClaimBeansViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Notifications - check bean code
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkBeanCodesSuccess:) name:CHECK_BEAN_CODE_SUCCESS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkBeanCodesFailure:) name:CHECK_BEAN_CODE_FAILURE_NOTIFICATION object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hideKeyboard:(id)sender
{
    [sender resignFirstResponder];
}

- (IBAction)hideKeyboardTouchDown:(id)sender
{
    [_tokenInput resignFirstResponder];
}


- (IBAction)claimBeansAction:(id)sender
{
    [_tokenInput resignFirstResponder];
    
    // Check bean code
    [[APIService getService] checkBeanCodeValid:_tokenInput.text];
}

- (void)checkBeanCodesSuccess:(NSNotification *)notification
{
    NSLog(@" checkBeanCodesSuccess: %@", notification.object);
    
    BOOL isBeanCodeValid = [[notification.object valueForKey:@"valid"] intValue];
//    NSString *resultMsg = [notification.object objectForKey:@"message"];

    if (isBeanCodeValid == YES) {
        NSLog(@"Valid bean code, go on...");
    } else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Checking Bean Code" message:resultMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
    }
}

- (void)checkBeanCodesFailure:(NSNotification *)notification
{
    NSLog(@" checkBeanCodesFailure");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Checking Bean Code Failed" message:@"Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


- (void)viewDidUnload
{
    [self setTokenInput:nil];
    [super viewDidUnload];
}
@end
