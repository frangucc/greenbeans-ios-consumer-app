//
//  LoginViewController.m
//  ConsumerGB
//
//  Created by Srikanth on 1/23/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeBeansViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:LOGIN_SUCCESS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginFailure:) name:LOGIN_FAILURE_NOTIFICATION object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)hideKeyboard:(id)sender
{
    [sender resignFirstResponder];
    
    if (self.view.frame.origin.y < 0.0) {
        // move signup view down
        [UIView animateWithDuration:0.2 animations:^ {
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

- (IBAction)hideKeyboardTouchDown:(id)sender
{
    if ([_emailInput isFirstResponder]) {
        [_emailInput resignFirstResponder];
    } else if ([_passInput isFirstResponder]) {
        [_passInput resignFirstResponder];
    }

    if (self.view.frame.origin.y < 0.0) {
        // move signup view down
        [UIView animateWithDuration:0.2 animations:^ {
            self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"textFieldShouldBeginEditing: %f", self.view.frame.origin.y);
    
    if (self.view.frame.origin.y >= 0.0) {
        // move login view up
        [UIView animateWithDuration:0.3 animations:^ {
            self.view.frame = CGRectMake(0, -81, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    
    return YES;
}

- (IBAction)loginAction:(id)sender
{
    [self hideKeyboardTouchDown:nil];
    
    // MBProgressHUD start
    [[APIService getService] startHUD:self.view];

    NSMutableDictionary *user = [[NSMutableDictionary alloc] initWithObjectsAndKeys:_emailInput.text, @"email", _passInput.text, @"password", nil];
    [[APIService getService] login:user];
}


- (void)loginSuccess:(NSNotification *)notification
{
    NSLog(@" loginSuccess: %@", notification.object);
    
    // MBProgressHUD stop
    [[APIService getService] stopHUD:self.view];

    if (200 == [[notification.object objectForKey:@"status"] intValue]) {
        [[APIService getService] setUser:[notification.object objectForKey:@"user"]];
        [self performSegueWithIdentifier:@"loginSuccessSegue" sender:self];
    } else {
        NSString *msg = [notification.object objectForKey:@"message"];
        if (!msg || 0 == [msg length]) {
            msg = @"Please try again.";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)loginFailure:(NSNotification *)notification
{
    NSLog(@" loginFailure");
    
    // MBProgressHUD stop
    [[APIService getService] stopHUD:self.view];

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue");
    if ([[segue identifier] isEqualToString:@"loginSuccessSegue"])
    {
        // Get reference to HomeBeansVC
        
        // Pass any objects to the view controller here, like...
    }
}


- (void)viewDidUnload
{
    [self setEmailInput:nil];
    [self setPassInput:nil];
    [super viewDidUnload];
}

@end
