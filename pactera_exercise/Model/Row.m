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
static NSString *const DESCRIPTION = @"description";
static NSString *const IMAGE_HREF = @"imageHref";

- (NSDictionary *)toJSONDictionary
{
    NSMutableDictionary *info = [[[NSMutableDictionary alloc] init] autorelease];

    if (_title)
    {
        [info setValue:_title forKey:TITLE];
    }

    if (_desc)
    {
        [info setValue:_desc forKey:DESCRIPTION];
    }

    if (_imageHref)
    {
        [info setValue:_imageHref forKey:IMAGE_HREF];
    }

    NSDictionary *dic = info.copy;

    return dic;
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)json
{
    Row *object = [[Row alloc] init];

    if (json[TITLE] && json[TITLE] != [NSNull null])
    {
        object.title = json[TITLE];
    }

    if (json[DESCRIPTION] && json[DESCRIPTION] != [NSNull null])
    {
        object.desc = json[DESCRIPTION];
    }

    if (json[IMAGE_HREF] && json[IMAGE_HREF] != [NSNull null])
    {
        object.imageHref = json[IMAGE_HREF];
    }

    return object;
}


@end
