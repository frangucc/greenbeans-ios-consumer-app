//
//  LoginViewController.h
//  ConsumerGB
//
//  Created by Srikanth on 1/23/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIService.h"

@class HomeBeansViewController;

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailInput;
@property (weak, nonatomic) IBOutlet UITextField *passInput;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)hideKeyboardTouchDown:(id)sender;
- (IBAction)loginAction:(id)sender;

@end
