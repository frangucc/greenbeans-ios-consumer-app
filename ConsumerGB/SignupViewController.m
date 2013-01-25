//
//  SignupViewController.m
//  ConsumerGB
//
//  Created by Srikanth on 1/23/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import "SignupViewController.h"
#import "LoginViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Notifications
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signupSuccess:) name:SIGNUP_SUCCESS_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signupFailure:) name:SIGNUP_FAILURE_NOTIFICATION object:nil];
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
    if ([_nameInput isFirstResponder]) {
        [_nameInput resignFirstResponder];
    } else if ([_emailInput isFirstResponder]) {
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
        // move signup view up
        [UIView animateWithDuration:0.3 animations:^ {
            self.view.frame = CGRectMake(0, -81, self.view.frame.size.width, self.view.frame.size.height);
        }];
    }
    
    return YES;
}


- (IBAction)signupAction:(id)sender
{
    [self hideKeyboardTouchDown:nil];
    
    // MBProgressHUD start
    [[APIService getService] startHUD:self.view];
    
    NSMutableDictionary *user = [[NSMutableDictionary alloc] initWithObjectsAndKeys:_emailInput.text, @"email", _passInput.text, @"password", nil];
    [[APIService getService] signup:user];
}

- (void)signupSuccess:(NSNotification *)notification
{
    NSLog(@" signupSuccess: %@", notification.object);
    
    // MBProgressHUD stop
    [[APIService getService] stopHUD:self.view];
    
    if (200 == [[notification.object objectForKey:@"status"] intValue]) {
        [self performSegueWithIdentifier:@"gotoLoginScreenSegue" sender:self];
    } else {
        // Reset email & password fields
        _emailInput.text = @"";
        _passInput.text = @"";
        
        NSString *errMsg = [[notification.object objectForKey:@"message"] objectAtIndex:0];
        if (!errMsg || 0 == [errMsg length]) {
            errMsg = @"Please try again";
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Signup Failed" message:errMsg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];        
    }
}

- (void)signupFailure:(NSNotification *)notification
{
    NSLog(@" signupFailure");
    
    // MBProgressHUD stop
    [[APIService getService] stopHUD:self.view];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Signup Failed" message:@"Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue");
    if ([[segue identifier] isEqualToString:@"gotoLoginScreenSegue"]) {
        //Get reference to LoginVC
        LoginViewController *loginVC = [segue destinationViewController];
        
        // Pass email/password
        loginVC.email = _emailInput.text;
        loginVC.password = _passInput.text;
    }
}



- (void)viewDidUnload {
    [self setNameInput:nil];
    [self setEmailInput:nil];
    [self setPassInput:nil];
    [super viewDidUnload];
}
@end
