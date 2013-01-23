//
//  SignupViewController.h
//  ConsumerGB
//
//  Created by Anh Viet on 1/23/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameInput;
@property (weak, nonatomic) IBOutlet UITextField *emailInput;
@property (weak, nonatomic) IBOutlet UITextField *passInput;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)hideKeyboardTouchDown:(id)sender;
@end
