//
//  RowTest.m
//  pactera_exercise
//
//  Created by jiakai lian on 14/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Row.h"

@interface RowTest : XCTestCase

@end

@implementation RowTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRowInitializer {
    NSString * title = @"RowTitle";
    NSString * description = @"descriptiondescription";
    NSString * imageHref = @"imageHrefimageHref";
    
    Row *row = [[Row alloc] initWithTitle:title description:description imageHref:imageHref];
    XCTAssertTrue([row->title isEqualToString:title]);
    XCTAssertTrue([row->description isEqualToString:description]);
    XCTAssertTrue([row->imageHref isEqualToString:imageHref]);
    
}


- (void)testRowDescription {
    NSString * title = @"RowTitle";
    NSString * description = @"descriptiondescription";
    NSString * imageHref = @"imageHrefimageHref";
    
    Row *row = [[Row alloc] initWithTitle:title description:description imageHref:imageHref];

    NSString * desc = [row description] ;
    
    NSLog(@"row desc =  %@", desc);
    
    
    XCTAssertTrue([desc containsString:title]);
    XCTAssertTrue([desc containsString:description]);
    XCTAssertTrue([desc containsString:imageHref]);
}

- (void)testRowToJSONString {
    NSString * title = @"RowTitle";
    NSString * description = @"descriptiondescription";
    NSString * imageHref = @"imageHrefimageHref";
    
    Row *row = [[Row alloc] initWithTitle:title description:description imageHref:imageHref];
    
    NSString * json = [row toJSONString] ;
    
    NSLog(@"row desc =  %@", json);
    
    
    XCTAssertTrue([json containsString:title]);
    XCTAssertTrue([json containsString:description]);
    XCTAssertTrue([json containsString:imageHref]);
}

- (void)testRowFromJSONString {
    NSString * original = @"{\n"
            "\t\"title\":\"Hockey Night in Canada\",\n"
            "\t\"description\":\"These Saturday night CBC broadcasts originally aired on radio in 1931. In 1952 they debuted on television and continue to unite (and divide) the nation each week.\",\n"
            "\t\"imageHref\":\"http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg\"\n"
            "\t}";

    Row *row = [Row fromJSONString:original];

    XCTAssertTrue([row->title isEqualToString:@"Hockey Night in Canada"]);
    XCTAssertTrue([row->description isEqualToString:@"These Saturday night CBC broadcasts originally aired on radio in 1931. In 1952 they debuted on television and continue to unite (and divide) the nation each week."]);
    XCTAssertTrue([row->imageHref isEqualToString:@"http://fyimusic.ca/wp-content/uploads/2008/06/hockey-night-in-canada.thumbnail.jpg"]);
}



@end
