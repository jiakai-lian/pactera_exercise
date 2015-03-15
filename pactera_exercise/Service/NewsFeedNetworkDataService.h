//
//  NewsFeedNetworkDataService.h
//  pactera_exercise
//
//  Created by jiakai lian on 14/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsFeedDataService.h"

@interface NewsFeedNetworkDataService : NSObject <NewsFeedDataService>
{
@private
    NSURLConnection *connection;
    SucessBlock sucessBlock;
    FailureBlock failureBlock;
}

@property(nonatomic, retain) NewsFeed *newsFeed;
@property(nonatomic, retain) NSMutableData *responseData;
@end
