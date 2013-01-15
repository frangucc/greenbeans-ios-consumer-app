//
//  APIService.m
//  ConsumerGB
//
//  Created by Srikanth on 1/15/13.
//  Copyright (c) 2013 GreenBeans. All rights reserved.
//

#import "APIService.h"

@implementation APIService

static APIService * service;

+ (APIService *)getService
{
    if (service) {
        return service;
    }
    static dispatch_once_t pred;        // Lock
    dispatch_once(&pred, ^{             // This code is called at most once per app's life cycle
        service = [[APIService alloc] init];
    });
    
    return service;
}

- (id)init
{
    self = [super init];
    return self;
}


- (void)checkBeanCodeValid:(NSString*)beanCode
{
    NSLog(@"APIService - checkBeanCodeValid: %@", beanCode);
    [self setNetworkQueue:[ASINetworkQueue queue]];
	[[self networkQueue] setDelegate:self];
    
    NSString *checkBeanCodeURL = [NSString stringWithFormat:@"%@%@", API_CHECK_BEAN_CODE, beanCode];
    NSLog(@"checkBeanCodeURL: %@", checkBeanCodeURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:checkBeanCodeURL]];
    
    [request setDelegate:self];
	[request setDidFinishSelector:@selector(checkBeanCodeFinished:)];
	[request setDidFailSelector:@selector(checkBeanCodeFailed:)];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"GET"];
    [request setTimeOutSeconds:10];

    [[self networkQueue] addOperation:request];
    
    [[self networkQueue] setQueueDidFinishSelector:@selector(checkBeanCodeQueueFinished:)];

    [[self networkQueue] go];
}

- (void)checkBeanCodeFinished:(ASIHTTPRequest *)request
{
	// Handle success
    NSString *theJSON = [request responseString];
    NSLog(@"  checkBeanCodeFinished: %@", theJSON);
    [[NSNotificationCenter defaultCenter] postNotificationName:CHECK_BEAN_CODE_SUCCESS_NOTIFICATION object:[theJSON JSONValue]];

}

- (void)checkBeanCodeFailed:(ASIHTTPRequest *)request
{
    NSLog(@"  checkBeanCodeFailed");
    [[NSNotificationCenter defaultCenter] postNotificationName:CHECK_BEAN_CODE_FAILURE_NOTIFICATION object:nil];
}

- (void)checkBeanCodeQueueFinished:(ASINetworkQueue *)queue
{
	// Could release the queue here
	if ([[self networkQueue] requestsCount] == 0) {
		[self setNetworkQueue:nil];
	}
	NSLog(@"Queue finished");
}



@end
