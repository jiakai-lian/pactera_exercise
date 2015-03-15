//
//  NewsFeedNetworkDataServiceTest.m
//  pactera_exercise
//
//  Created by jiakai lian on 15/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NewsFeedNetworkDataService.h"
#import "NewsFeed.h"

@interface NewsFeedNetworkDataServiceTest : XCTestCase

@end

@implementation NewsFeedNetworkDataServiceTest

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testGetNewsFeed
{
    NewsFeedNetworkDataService *service = [[NewsFeedNetworkDataService alloc] init];
    XCTestExpectation *expectation = [self expectationWithDescription:@"GetNewsFeed request"];


    [service getNewsFeedWithSuccessBlock:^(NewsFeed *newsFeed)
    {
        XCTAssertNotNil(newsFeed);
        NSLog(@"newsfeed = %@", [newsFeed toJSONString]);

        [newsFeed release];

        [expectation fulfill];

    }                    andFailureBlock:^(NSError *error)
    {
        XCTAssertTrue(NO);

        [error release];
    }];


    [service release];

    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}

@end
