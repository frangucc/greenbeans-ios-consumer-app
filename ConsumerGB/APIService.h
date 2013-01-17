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

#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define API_CHECK_BEAN_CODE @"http://107.20.196.96/api/consumer/beans/validate.json?code="

#define CHECK_BEAN_CODE_SUCCESS_NOTIFICATION @"CHECK_BEAN_CODE_SUCCESS_NOTIFICATION"
#define CHECK_BEAN_CODE_FAILURE_NOTIFICATION @"CHECK_BEAN_CODE_FAILURE_NOTIFICATION"

@interface APIService : NSObject

@property (retain) ASINetworkQueue *networkQueue;

+ (id)getService;
- (void)checkBeanCodeValid:(NSString*)beanCode;

@end
