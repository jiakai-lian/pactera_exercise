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

#pragma mark - JSON Support

static NSString *const TITLE = @"title";
static NSString *const ROWS = @"rows";


- (NSDictionary *)toJSONDictionary
{
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    
    if (title)
    {
        [info setValue:title forKey:TITLE];
    }
    
    if (rows)
    {
        NSMutableArray *array = [NSMutableArray array];
        for(Row *row in rows)
        {
            [array addObject:[row toJSONDictionary]];
        }
        [info setValue:array forKey:ROWS];
    }
    
    
    return info;
}

+ (id)fromJSONDictionary:(NSDictionary *)json
{
    NewsFeed *object = [[NewsFeed alloc] init];
    
    if(json[TITLE] && json[TITLE]!=[NSNull null])
    {
        object->title = json[TITLE];
    }
    
    NSMutableArray<Row> *array = (NSMutableArray<Row> *)[NSMutableArray array];
    for(NSDictionary *dic in json[ROWS])
    {
        [array addObject:[Row fromJSONDictionary:dic]];
    }
    object->rows = array;
    
    return object;
}


@end
