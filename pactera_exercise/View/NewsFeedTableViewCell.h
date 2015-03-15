//
//  NewsFeedTableViewCell.h
//  pactera_exercise
//
//  Created by jiakai lian on 15/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsFeedTableViewCell : UITableViewCell

@property(retain, nonatomic) IBOutlet UILabel *labelTitle;
@property(retain, nonatomic) IBOutlet UILabel *labelDesc;
@property(retain, nonatomic) IBOutlet UIImageView *imageViewRow;

@end
