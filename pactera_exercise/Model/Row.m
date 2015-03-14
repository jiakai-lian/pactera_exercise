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


#pragma mark - JSON Support

static NSString *const TITLE = @"title";
static NSString *const DESCRPTION = @"description";
static NSString *const IMAGE_HERF = @"imageHref";

- (NSDictionary *)toJSONDictionary
{
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];
    
    if (title)
    {
        [info setValue:title forKey:TITLE];
    }
    
    if (description)
    {
        [info setValue:description forKey:DESCRPTION];
    }
    
    if (imageHref)
    {
        [info setValue:imageHref forKey:IMAGE_HERF];
    }
    
    return info;
}

+ (id)fromJSONDictionary:(NSDictionary *)json
{
    Row *object = [[Row alloc] init];
    
    if(json[TITLE] && json[TITLE]!=[NSNull null])
    {
        object->title = json[TITLE];
    }
    
    if(json[DESCRPTION] && json[DESCRPTION]!=[NSNull null])
    {
        object->description = json[DESCRPTION];
    }
    
    if(json[IMAGE_HERF] && json[IMAGE_HERF]!=[NSNull null])
    {
        object->imageHref = json[IMAGE_HERF];
    }
    
    return object;
}


@end
