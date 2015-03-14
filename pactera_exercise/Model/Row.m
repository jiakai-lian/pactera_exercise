//
//  Row.m
//  pactera_exercise
//  Model class of Row
//  Created by jiakai lian on 14/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import "Row.h"
#import "Common.h"

@implementation Row
- (instancetype)initWithTitle:(NSString *)aTitle description:(NSString *)aDescription imageHref:(NSString *)anImageHref
{
    self = [super init];
    if (self)
    {
        title = [aTitle copy];
        description = [aDescription copy];
        imageHref = [anImageHref copy];
    }

    return self;
}


- (void)dealloc
{
    [title release];
    [description release];
    [imageHref release];
    
    [super dealloc];
}

- (NSString *)description
{
    NSMutableString *desc = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [desc appendFormat:@"title=%@", title];
    [desc appendFormat:@", description=%@", description];
    [desc appendFormat:@", imageHref=%@", imageHref];
    [desc appendString:@">"];
    return desc;
}


@end
