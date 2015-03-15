//
//  NewsFeedNetworkDataService.m
//  pactera_exercise
//
//  Created by jiakai lian on 14/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import "NewsFeedNetworkDataService.h"
#import "Common.h"
#import "NewsFeed.h"

@implementation NewsFeedNetworkDataService

static NSUInteger const TIMEOUT = 10;

static NSString *const GET = @"get";

- (void)dealloc
{
    [connection release];
    connection = nil;

    [_responseData release];
    _responseData = nil;

    [_newsFeed release];
    _newsFeed = nil;

    [super dealloc];
}


- (void)getNewsFeedWithSucessBlock:(SucessBlock)success andFailureBlock:(FailureBlock)failure;
{
    sucessBlock = Block_copy(success);
    failureBlock = Block_copy(failure);

    NSString *url = @"https://dl.dropboxusercontent.com/u/746330/facts.json";

    [self sendRequest:url HttpMethod:GET Data:nil];

    [url release];
}



#pragma mark - NSURLConnectionDelegate

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    LOG(@"Retain count  %d", [_responseData retainCount]);
    [_responseData retain];
    [_responseData setLength:0];
    [_responseData release];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [data retain];
    [_responseData retain];
    LOG(@"Retain count  %d", [_responseData retainCount]);
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.

    [_responseData appendData:data];

    [_responseData release];
    [data release];
}

- (void)connection:(NSURLConnection *)conn
  didFailWithError:(NSError *)error
{
    [error retain];

    [connection release];
    connection = nil;

    [_responseData release];
    _responseData = nil;

    // inform error
    NSLog(@"Connection failed! Error - %@ %@",
            [error localizedDescription],
            [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);

    if (failureBlock)
    {
        failureBlock(error);
    }

    [error release];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    NSLog(@"Succeeded! Received %lu bytes of data", (unsigned long) [_responseData length]);

    NSString *json = [[NSString alloc] initWithData:_responseData encoding:NSASCIIStringEncoding];
    NSLog(@"data = %@", json);

    _newsFeed = [[NewsFeed fromJSONString:json] retain];

    [json release];
    json = nil;

    [connection release];
    connection = nil;

    [_responseData release];
    _responseData = nil;

    if (sucessBlock)
    {
        sucessBlock(_newsFeed);
    }

}



#pragma mark - Send Request

- (NSData *)sendRequest:(NSString *)url HttpMethod:(NSString *)httpMethod Data:(NSData *)data
{
    [url retain];
    [httpMethod retain];
    [data retain];

    _responseData = [[NSMutableData dataWithCapacity:0] retain];//clear the response first
    LOG(@"Retain count  %d", [_responseData retainCount]);

    NSMutableURLRequest *request = [[NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                            cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                        timeoutInterval:TIMEOUT] retain];

    LOG(@"URL = %@", url);

    [request setHTTPMethod:httpMethod];

    //[request addValue:@"application/json" forHTTPHeaderField:@"content-type"];

    //[request setHTTPBody:data];

    connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];


    if (!connection)
    {
        // Release the receivedData object.
        [_responseData release];
        _responseData = nil;

        // Inform the user that the connection failed.
    }


    LOG(@"Retain count  %d", [_responseData retainCount]);

    [request release];

    [url release];
    [httpMethod release];
    [data release];

    return nil;
}

@end
