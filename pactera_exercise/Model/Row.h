//
//  Row.h
//  pactera_exercise
//  Model class of Row
//  Created by jiakai lian on 14/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol Row

@end

@interface Row : NSObject
{
@public
    NSString *title;        //title of the row
    NSString *description;  // description of the row
    NSString *imageHref;    //image url
}
- (instancetype)initWithTitle:(NSString *)aTitle description:(NSString *)aDescription imageHref:(NSString *)anImageHref;

- (NSString *)description;

@end
