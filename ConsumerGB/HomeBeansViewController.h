//
//  HomeBeansViewController.h
//  ConsumerGB
//
//  Created by Srikanth on 1/16/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIService.h"

@class ActiveBeansCollectionViewController;
@class BeansTabBarController;

@interface HomeBeansViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *youHaveBeansLabel;
@property (strong, nonatomic) ActiveBeansCollectionViewController *activeBeansVC;

@end
