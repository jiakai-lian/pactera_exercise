//
//  Row.h
//  pactera_exercise
//  Model class of Row
//  Created by jiakai lian on 14/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//
#import "NSObject+JSON.h"
#import <Foundation/Foundation.h>

@protocol Row

@end

@interface Row : NSObject
//{
//@private
//    NSString *title;        //title of the row
//    NSString *desc;  // description of the row
//    NSString *imageHref;    //image url
//}

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *desc;
@property(nonatomic, copy) NSString *imageHref;

- (instancetype)initWithTitle:(NSString *)aTitle description:(NSString *)aDescription imageHref:(NSString *)anImageHref NS_DESIGNATED_INITIALIZER;

- (NSString *)description;

@end
