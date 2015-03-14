//
//  NewsFeedDataService.h
//  pactera_exercise
//
//  protocol of NewsFeed Data service
//  the application should use this protocol to get newsfeed, instead of communicating with a particular data service class. By doing this, we can easily adapt data source from network, file, db, core data etc.
//
//  Created by jiakai lian on 14/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NewsFeed;

typedef void(^SucessBlock)(NewsFeed * newsFeed);
typedef void(^FailureBlock)(NSError *error);

@protocol NewsFeedDataService <NSObject>

/**
 *  a protocol method to get newsfeed
 *
 *  @param success block to execute when success
 *  @param failure block to execute when failure
 */
- (void)getNewsFeedWithSucessBlock:(SucessBlock)success andFailureBlock:(FailureBlock) failure;

@end
