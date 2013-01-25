//
//  SignupViewController.h
//  ConsumerGB
//
//  Created by Srikanth on 1/23/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIService.h"

@class LoginViewController;

@interface SignupViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UITextField *emailInput;
@property (weak, nonatomic) IBOutlet UITextField *passInput;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)hideKeyboardTouchDown:(id)sender;
- (IBAction)signupAction:(id)sender;

@end
