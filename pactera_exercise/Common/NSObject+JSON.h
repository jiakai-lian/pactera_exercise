//
//  NSObject+JSON.h
//  pactera_exercise
//
//  Created by jiakai lian on 14/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSON)

- (NSString *)toJSONString;

//convert to json string
- (NSMutableDictionary *)toJSONDictionary;

//convert to json dictionary
+ (id)fromJSONDictionary:(NSDictionary *)dictionary;


+ (id)fromJSONString:(NSString *)str;

@end
