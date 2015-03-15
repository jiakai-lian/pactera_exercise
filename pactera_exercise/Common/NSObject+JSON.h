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
- (NSDictionary *)toJSONDictionary;

//convert to json dictionary
+ (instancetype)fromJSONDictionary:(NSDictionary *)dictionary;


+ (instancetype)fromJSONString:(NSString *)str;

@end
