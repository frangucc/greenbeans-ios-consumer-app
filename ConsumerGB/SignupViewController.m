//
//  SignupViewController.m
//  ConsumerGB
//
//  Created by Anh Viet on 1/23/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import "SignupViewController.h"

@interface SignupViewController ()

@end

@implementation SignupViewController

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


- (void)viewDidUnload {
    [self setNameInput:nil];
    [self setEmailInput:nil];
    [self setPassInput:nil];
    [super viewDidUnload];
}
@end
