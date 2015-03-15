//
//  Row.m
//  pactera_exercise
//  Model class of Row
//  Created by jiakai lian on 14/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import "Row.h"

@implementation Row
- (instancetype)initWithTitle:(NSString *)aTitle description:(NSString *)aDescription imageHref:(NSString *)anImageHref
{
    self = [super init];
    if (self)
    {
        _title = [aTitle copy];
        _desc = [aDescription copy];
        _imageHref = [anImageHref copy];
    }

    return self;
}


- (void)dealloc
{
    [_title release];
    [_desc release];
    [_imageHref release];

    _title = nil;
    _desc = nil;
    _imageHref = nil;

    [super dealloc];
}

//- (void)setTitle:(NSString *)titleString
//{
//    [_title release];
//    _title = [titleString copy];
//}
//
//- (void)setDesc:(NSString *)descString
//{
//    [_desc release];
//    _desc = [descString copy];
//}
//
//- (void)setImageHref:(NSString *)imageHrefString
//{
//    [_imageHref release];
//    _imageHref = [imageHrefString copy];
//}

- (NSString *)description
{
    NSMutableString *d = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [d appendFormat:@"title=%@", _title];
    [d appendFormat:@", description=%@", _desc];
    [d appendFormat:@", imageHref=%@", _imageHref];
    [d appendString:@">"];
    return d;
}


#pragma mark - JSON Support

static NSString *const TITLE = @"title";
static NSString *const DESCRPTION = @"description";
static NSString *const IMAGE_HERF = @"imageHref";

- (NSDictionary *)toJSONDictionary
{
    NSMutableDictionary *info = [[NSMutableDictionary alloc] init];

    if (_title)
    {
        [info setValue:_title forKey:TITLE];
    }

    if (_desc)
    {
        [info setValue:_desc forKey:DESCRPTION];
    }

    if (_imageHref)
    {
        [info setValue:_imageHref forKey:IMAGE_HERF];
    }

    return info;
}

+ (id)fromJSONDictionary:(NSDictionary *)json
{
    Row *object = [[Row alloc] init];

    if (json[TITLE] && json[TITLE] != [NSNull null])
    {
        object.title = json[TITLE];
    }

    if (json[DESCRPTION] && json[DESCRPTION] != [NSNull null])
    {
        object.desc = json[DESCRPTION];
    }

    if (json[IMAGE_HERF] && json[IMAGE_HERF] != [NSNull null])
    {
        object.imageHref = json[IMAGE_HERF];
    }

    return object;
}


@end
