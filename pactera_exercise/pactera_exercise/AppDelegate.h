//
//  AppDelegate.h
//  pactera_exercise
//
//  Created by jiakai lian on 14/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsFeedDataService.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(strong, nonatomic) UIWindow *window;

@property(nonatomic, retain) NSObject <NewsFeedDataService> *service;


@end

