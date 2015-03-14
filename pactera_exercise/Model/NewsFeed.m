//
//  NewsFeed.m
//  pactera_exercise
//  Model class of NewsFeed
//  Created by jiakai lian on 14/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import "NewsFeed.h"

@implementation NewsFeed
- (instancetype)initWithTitle:(NSString *)aTitle rows:(NSArray <Row> *)aRows
{
    self = [super init];
    if (self)
    {
        title = [aTitle copy];
        rows = [aRows retain];
    }

    return self;
}

- (void)dealloc
{
    [title release];
    [rows release];
    [super dealloc];
}

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"title=%@", title];
    [description appendFormat:@", rows=%@", rows];
    [description appendString:@">"];
    return description;
}


@end
