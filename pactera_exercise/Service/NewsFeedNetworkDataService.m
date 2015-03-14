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


- (void)getNewsFeedWithSucessBlock:(SucessBlock)success andFailureBlock:(FailureBlock) failure;
{
    sucessBlock = [success  retain];
    failureBlock = [failure retain];
    
    NSString *url = @"https://dl.dropboxusercontent.com/u/746330/facts.json";
    
    [self sendRequest:url HttpMethod:GET Data:nil];
}



#pragma mark - NSURLConnectionDelegate

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return YES;
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)conn
  didFailWithError:(NSError *)error
{
    [connection release];
    connection = nil;
    
    [_responseData release];
    _responseData = nil;
    
    // inform error
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSURLErrorFailingURLStringErrorKey]);
    
    if(failureBlock)
    {
        failureBlock(error);
        [failureBlock release];
        failureBlock = nil;
        
        [sucessBlock release];
        sucessBlock = nil;
        
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn
{
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[_responseData length]);
    NSLog(@"data = %@",[[NSString alloc] initWithData:_responseData encoding:NSASCIIStringEncoding]);
    
    _newsFeed = [NewsFeed fromJSONString:[[NSString alloc] initWithData:_responseData encoding:NSASCIIStringEncoding]];
    
    if(sucessBlock)
    {
        sucessBlock(_newsFeed);
        
        [failureBlock release];
        failureBlock = nil;
        
        [sucessBlock release];
        sucessBlock = nil;
    }
    
    [connection release];
    connection = nil;
    
    [_responseData release];
    _responseData = nil;
}



#pragma mark - Send Request

- (NSData *)sendRequest:(NSString *)url HttpMethod:(NSString *)httpMethod Data:(NSData *)data
{
    _responseData = [[NSMutableData dataWithCapacity: 0] retain];//clear the response first
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:TIMEOUT];
    
    LOG(@"URL = %@", url);
    
    [request setHTTPMethod:httpMethod];
    
    //[request addValue:@"application/json" forHTTPHeaderField:@"content-type"];
    
    //[request setHTTPBody:data];
    
    connection=[[[NSURLConnection alloc] initWithRequest:request delegate:self] retain];
    
    [request release];
    
    if (!connection) {
        // Release the receivedData object.
        _responseData = nil;
        
        // Inform the user that the connection failed.
    }
    return nil;
}

@end
