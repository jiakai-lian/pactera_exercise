//
//  NSObject+JSON.m
//  pactera_exercise
//
//  Created by jiakai lian on 14/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import "Common.h"
#import "NSObject+JSON.h"

@implementation NSObject (JSON)


- (NSString *)toJSONString
{
    NSError *error;

    //convert object to data
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self toJSONDictionary]
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    return str;
}

//!!!!!!!  this mehtod shouldn't be called. It has to be override by sub classes
- (NSDictionary *)toJSONDictionary
{
    LOG("this mehtod shouldn't be called. It has to be override by sub classes");
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    return info;
}

//!!!!!!! this mehtod shouldn't be called. It has to be override by sub classes
+ (id)fromJSONDictionary:(NSDictionary *)json
{
    LOG("this mehtod shouldn't be called. It has to be override by sub classes");
    return nil;
}

+ (id)fromJSONString:(NSString *)str
{
    if (!str)
    {
        return nil;
    }

    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    //parse out the json data
    NSError *error;
    NSDictionary *json = [NSJSONSerialization
            JSONObjectWithData:data

                       options:NSJSONReadingMutableContainers
                         error:&error];

    return [self fromJSONDictionary:json];
}


@end
