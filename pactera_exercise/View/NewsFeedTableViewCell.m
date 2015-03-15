//
//  NewsFeedTableViewCell.m
//  pactera_exercise
//
//  Created by jiakai lian on 15/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import "NewsFeedTableViewCell.h"

@implementation NewsFeedTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [_labelTitle release];
    [_labelDesc release];
    [_imageViewRow release];
    [super dealloc];
}

@end
