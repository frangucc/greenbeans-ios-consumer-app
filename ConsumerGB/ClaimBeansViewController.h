//
//  ClaimBeansViewController.h
//  ConsumerGB
//
//  Created by Srikanth on 1/15/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIService.h"

@interface ClaimBeansViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *tokenInput;
@property (weak, nonatomic) IBOutlet UIView *claimBeansBlockView;
@property (weak, nonatomic) IBOutlet UIImageView *errMsg;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)hideKeyboardTouchDown:(id)sender;
- (IBAction)claimBeansAction:(id)sender;
- (IBAction)myBeansAction:(id)sender;

@end
