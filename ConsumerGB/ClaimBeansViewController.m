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

    if (isBeanCodeValid == YES) {
        NSLog(@"Valid bean code, go to Home Beans: %@", self.navigationController);
        [self performSegueWithIdentifier:@"toHomeBeansSegue" sender:self];
    } else {
        // Anim: move claim beans block down to show the error message
        [UIView animateWithDuration:0.3 animations:^ {
            _claimBeansBlockView.frame = CGRectMake(0, 155, _claimBeansBlockView.frame.size.width, _claimBeansBlockView.frame.size.height);
        }];
        // Show the error message box
        [_errMsg setHidden:NO];
    }
}

- (void)checkBeanCodesFailure:(NSNotification *)notification
{
    NSLog(@" checkBeanCodesFailure");
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Checking Bean Code Failed" message:@"Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


- (IBAction)myBeansAction:(id)sender
{
    if ([self isUserLoggedIn]) {
        [self performSegueWithIdentifier:@"myBeansToHomeBeansSegue" sender:self];
    } else {
        [self performSegueWithIdentifier:@"myBeansToSignupSegue" sender:self];
    }
}


- (BOOL)isUserLoggedIn
{
    return NO;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setTokenInput:nil];
    [self setClaimBeansBlockView:nil];
    [self setErrMsg:nil];
}
@end
