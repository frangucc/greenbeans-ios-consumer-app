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

/**
 * CHECK BEAN CODE
 */
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
    NSString *theJsonStr = [request responseString];
//    NSLog(@"  checkBeanCodeFinished: %@", theJsonStr);
    if ([theJsonStr JSONValue] != [NSNull null]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CHECK_BEAN_CODE_SUCCESS_NOTIFICATION object:[theJsonStr JSONValue]];
    } else {
         [[NSNotificationCenter defaultCenter] postNotificationName:CHECK_BEAN_CODE_FAILURE_NOTIFICATION object:nil];
    }
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


/**
 * LOGIN
 */
- (void)login:(NSMutableDictionary*)user
{
    NSLog(@"APIService - login: %@", user);

    [self setNetworkQueue:[ASINetworkQueue queue]];
	[[self networkQueue] setDelegate:self];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:API_LOGIN]];
    
    [request setDelegate:self];
	[request setDidFinishSelector:@selector(loginFinished:)];
	[request setDidFailSelector:@selector(loginFailed:)];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"POST"];
    [request setPostValue:[user objectForKey:@"email"] forKey:@"user[email]"];
    [request setPostValue:[user objectForKey:@"password"] forKey:@"user[password]"];
    [request setTimeOutSeconds:10];
    
    [[self networkQueue] addOperation:request];
    
    [[self networkQueue] setQueueDidFinishSelector:@selector(loginQueueFinished:)];
    
    [[self networkQueue] go];
}

- (void)loginFinished:(ASIHTTPRequest *)request
{
    NSString *theJsonStr = [request responseString];
//    NSLog(@"loginFinished: %@", theJsonStr);
    if ([theJsonStr JSONValue] != [NSNull null]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_SUCCESS_NOTIFICATION object:[theJsonStr JSONValue]];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_FAILURE_NOTIFICATION object:nil];
    }
}

- (void)loginFailed:(ASIHTTPRequest *)request
{
    NSLog(@"loginFailed");
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_FAILURE_NOTIFICATION object:nil];
}

- (void)loginQueueFinished:(ASINetworkQueue *)queue
{
	// Could release the queue here
	if ([[self networkQueue] requestsCount] == 0) {
		[self setNetworkQueue:nil];
	}
	NSLog(@"Queue finished");
}


/**
 * GET CONSUMER BEANS
 */
- (void)getConsumerBeans
{
    NSLog(@"APIService - getConsumerBeans");
    
    [self setNetworkQueue:[ASINetworkQueue queue]];
	[[self networkQueue] setDelegate:self];
    
    NSString *authToken = [[[APIService getService] getUser] objectForKey:@"auth_token"];
    NSString *getConsumerBeansURL = [NSString stringWithFormat:@"%@%@", API_GET_CONSUMER_BEANS, authToken];
    NSLog(@" getConsumerBeansURL: %@", getConsumerBeansURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:getConsumerBeansURL]];
    
    [request setDelegate:self];
	[request setDidFinishSelector:@selector(getConsumerBeansFinished:)];
	[request setDidFailSelector:@selector(getConsumerBeansFailed:)];
    [request addRequestHeader:@"Content-Type" value:@"application/json"];
    [request addRequestHeader:@"Accept" value:@"application/json"];
    [request setRequestMethod:@"GET"];
    [request setTimeOutSeconds:10];
    
    [[self networkQueue] addOperation:request];
    
    [[self networkQueue] setQueueDidFinishSelector:@selector(getConsumerBeansQueueFinished:)];
    
    [[self networkQueue] go];
}

- (void)getConsumerBeansFinished:(ASIHTTPRequest *)request
{
    NSString *theJsonStr = [request responseString];
    NSLog(@"getConsumerBeansFinished: %@", theJsonStr);
    if ([theJsonStr JSONValue] != [NSNull null]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:GET_CONSUMER_BEANS_SUCCESS_NOTIFICATION object:[theJsonStr JSONValue]];
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:GET_CONSUMER_BEANS_FAILURE_NOTIFICATION object:nil];
    }

}

- (void)getConsumerBeansFailed:(ASIHTTPRequest *)request
{
    NSString *theJsonStr = [request responseString];
    NSLog(@"getConsumerBeansFailed: %@", theJsonStr);
    [[NSNotificationCenter defaultCenter] postNotificationName:GET_CONSUMER_BEANS_FAILURE_NOTIFICATION object:[theJsonStr JSONValue]];
}

- (void)getConsumerBeansQueueFinished:(ASINetworkQueue *)queue
{
	// Could release the queue here
	if ([[self networkQueue] requestsCount] == 0) {
		[self setNetworkQueue:nil];
	}
	NSLog(@"Queue finished");
}


/**
 * GET/SET LOGGED-IN USER
 */

- (NSMutableDictionary*)getUser
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *data = [prefs objectForKey:@"currentLoggedinUser"];
    NSMutableDictionary *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return user;
}

- (void)setUser:(NSMutableDictionary*)user
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
    [prefs setObject:data forKey:@"currentLoggedinUser"];
}


@end
