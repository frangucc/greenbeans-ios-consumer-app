//
//  APIService.h
//  ConsumerGB
//
//  Created by Srikanth on 1/15/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"
#import "SBJson.h"
#import "MBProgressHUD.h"

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define API_CHECK_BEAN_CODE @"http://107.20.196.96/api/consumer/beans/validate.json?code="
#define API_LOGIN @"http://107.20.196.96/api/consumer/sessions.json"
#define API_GET_CONSUMER_BEANS @"http://107.20.196.96/api/consumer/beans/my_beans.json?auth_token="
#define API_LOGOUT @"http://107.20.196.96/api/consumer/sessions/delete.json"
#define API_SIGNUP @"http://107.20.196.96/api/consumer/registrations.json"

#define CHECK_BEAN_CODE_SUCCESS_NOTIFICATION @"CHECK_BEAN_CODE_SUCCESS_NOTIFICATION"
#define CHECK_BEAN_CODE_FAILURE_NOTIFICATION @"CHECK_BEAN_CODE_FAILURE_NOTIFICATION"
#define LOGIN_SUCCESS_NOTIFICATION @"LOGIN_SUCCESS_NOTIFICATION"
#define LOGIN_FAILURE_NOTIFICATION @"LOGIN_FAILURE_NOTIFICATION"
#define LOGOUT_SUCCESS_NOTIFICATION @"LOGOUT_SUCCESS_NOTIFICATION"
#define LOGOUT_FAILURE_NOTIFICATION @"LOGOUT_FAILURE_NOTIFICATION"
#define GET_CONSUMER_BEANS_SUCCESS_NOTIFICATION @"GET_CONSUMER_BEANS_SUCCESS_NOTIFICATION"
#define GET_CONSUMER_BEANS_FAILURE_NOTIFICATION @"GET_CONSUMER_BEANS_FAILURE_NOTIFICATION"
#define SIGNUP_SUCCESS_NOTIFICATION @"SIGNUP_SUCCESS_NOTIFICATION"
#define SIGNUP_FAILURE_NOTIFICATION @"SIGNUP_FAILURE_NOTIFICATION"

@interface APIService : NSObject

@property (retain) ASINetworkQueue *networkQueue;

+ (id)getService;
- (void)checkBeanCodeValid:(NSString*)beanCode;
- (void)login:(NSMutableDictionary*)user;
- (void)getConsumerBeans;
- (void)logout;
- (void)signup:(NSMutableDictionary*)user;

- (NSMutableDictionary*)getUser;
- (void)setUser:(NSMutableDictionary*)user;
- (void)startHUD:(UIView*)theView;
- (void)stopHUD:(UIView*)theView;
@end
