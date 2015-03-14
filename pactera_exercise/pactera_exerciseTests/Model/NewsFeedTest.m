//
//  NewsFeedTest.m
//  pactera_exercise
//
//  Created by jiakai lian on 14/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NewsFeed.h"

@interface NewsFeedTest : XCTestCase

@end

@implementation NewsFeedTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNewsFeedInitializer {
    NSString * titleFeed = @"FeedTitle";
    NSString * title = @"RowTitle";
    NSString * description = @"RowDescription";
    NSString * imageHref = @"RowImageHref";
    
    Row *row = [[Row alloc] initWithTitle:title description:description imageHref:imageHref];
    NSArray<Row> * array = (NSArray<Row>  *)[[NSArray alloc]initWithObjects:row, nil];
    
    NewsFeed *feed = [[NewsFeed alloc] initWithTitle:titleFeed rows:array];
    
    XCTAssertTrue([feed.title isEqualToString:titleFeed]);
    XCTAssertTrue(feed.rows.count == 1 );
    XCTAssertTrue([[feed.rows firstObject] isEqual:row] );
    
    [row release];
    [array release];
    [feed release];
    
}


- (void)testNewsFeedDescription {
    NSString * titleFeed = @"FeedTitle";
    NSString * title = @"RowTitle";
    NSString * description = @"descriptiondescription";
    NSString * imageHref = @"imageHrefimageHref";
    
    Row *row = [[Row alloc] initWithTitle:title description:description imageHref:imageHref];
    NSArray<Row> * array = (NSArray<Row>  *)[[NSArray alloc]initWithObjects:row, nil];
    
    NewsFeed *feed = [[NewsFeed alloc] initWithTitle:titleFeed rows:array];
    
    NSString * desc = [feed description] ;
    NSLog(@"row desc =  %@", desc);
    
    
    XCTAssertTrue([desc containsString:titleFeed]);
    XCTAssertTrue([desc containsString:title]);
    XCTAssertTrue([desc containsString:description]);
    XCTAssertTrue([desc containsString:imageHref]);
    
    [row release];
    [array release];
    [feed release];
}


- (void)testNewsFeedToJSONString {
    NSString * titleFeed = @"FeedTitle";
    NSString * title = @"RowTitle";
    NSString * description = @"RowDescription";
    NSString * imageHref = @"RowImageHref";
    
    Row *row = [[Row alloc] initWithTitle:title description:description imageHref:imageHref];
    NSArray<Row> * array = (NSArray<Row>  *)[[NSArray alloc]initWithObjects:row, nil];
    
    NewsFeed *feed = [[NewsFeed alloc] initWithTitle:titleFeed rows:array];

    NSString * json = [feed toJSONString] ;
    
    NSLog(@"row desc =  %@", json);
    
    
    XCTAssertTrue([json containsString:titleFeed]);
    XCTAssertTrue([json containsString:title]);
    XCTAssertTrue([json containsString:description]);
    XCTAssertTrue([json containsString:imageHref]);
    
    [row release];
    [array release];
    [feed release];
    [json release];
}

- (void)testRowFromJSONString {
    NSString * original = @"{\n"
            "\"title\":\"About Canada\",\n"
            "\"rows\":[\n"
            "\t{\n"
            "\t\"title\":\"Beavers\",\n"
            "\t\"description\":\"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony\",\n"
            "\t\"imageHref\":\"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg\"\n"
            "\t}\n"
            "]\n"
            "}";
    
    NewsFeed *feed = [NewsFeed fromJSONString:original];
    
    XCTAssertTrue([feed.title isEqualToString:@"About Canada"]);
    XCTAssertTrue(feed.rows.count == 1);
    Row *row= [feed.rows firstObject];
    XCTAssertTrue([row.title isEqualToString:@"Beavers"]);
    XCTAssertTrue([row.desc isEqualToString:@"Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony"]);
    XCTAssertTrue([row.imageHref isEqualToString:@"http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"]);
    
    [row release];
    [feed release];
}


@end
