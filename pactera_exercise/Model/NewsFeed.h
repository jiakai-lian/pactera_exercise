//
//  NewsFeed.h
//  pactera_exercise
//  Model class of NewsFeed
//  Created by jiakai lian on 14/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//
#import "Row.h"
#import <Foundation/Foundation.h>
#import "NSObject+JSON.h"

@interface NewsFeed : NSObject
{
@public
    NSString *title;
    NSArray<Row> *rows;
}
- (instancetype)initWithTitle:(NSString *)aTitle rows:(NSArray <Row> *)aRows NS_DESIGNATED_INITIALIZER;

- (NSString *)description;

@end
