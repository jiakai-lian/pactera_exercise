//
//  NewsFeedTableViewController.m
//  pactera_exercise
//  A table view controller to display news feed
//  Created by jiakai lian on 15/03/2015.
//  Copyright (c) 2015 jiakai. All rights reserved.
//

#import "AppDelegate.h"
#import "Common.h"
#import "NewsFeed.h"
#import "NewsFeedTableViewCell.h"
#import "NewsFeedTableViewController.h"


@interface NewsFeedTableViewController ()
{
@private
    NewsFeed *feed; //news feed object
    NSMutableDictionary *imageCache; // a dictionary to store url as key, and  UIImage as value
}

@property(nonatomic, retain) AppDelegate *appDelegate;

@end

@implementation NewsFeedTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    feed = nil;
    imageCache = [[NSMutableDictionary dictionary] retain];
    _appDelegate = APP_DELEGATE;

    //init refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getLatestNewsFeed)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    NSMutableDictionary * newCache = [NSMutableDictionary dictionary];
    
    //save images in visible rows to new cache
    for(NSIndexPath *indexPath in self.tableView.indexPathsForVisibleRows)
    {
        NSString * imageHref = ((Row *)[feed.rows objectAtIndex:indexPath.row]).imageHref;
        if(imageCache[imageHref])
        {
            newCache[imageHref] = imageCache[imageHref];
        }
    }
    
    
    //replace the image cache by new cache
    [imageCache release];
    imageCache = [newCache retain];

}

- (void)dealloc
{
    if (feed)
    {
        [feed release];
        feed = nil;
    }

    [imageCache release];
    imageCache = nil;
    [_appDelegate release];
    _appDelegate = nil;

    [super dealloc];
}

#pragma mark - private methods
/**
 *  get latest news feed via data service
 */
- (void)getLatestNewsFeed
{
    [_appDelegate.service getNewsFeedWithSuccessBlock:^(NewsFeed *newsFeed)
    {
        feed = [newsFeed retain];
        self.title = feed.title;
        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];

    }                                 andFailureBlock:^(NSError *error)
    {
        if (feed)
        {
            [feed release];
            feed = nil;
        }

        [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    }];
}

/**
 *  reload data after get news feed
 */
- (void)reloadData
{
    // Reload table data
    [self.tableView reloadData];

    // End the refreshing
    if (self.refreshControl)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        [title retain];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        [self.refreshControl endRefreshing];


        [formatter release];
        [title release];
        [attributedTitle release];
    }
}

#pragma mark - Table view delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (feed.rows.count)
    {
        //1 section when feed has rows
        self.tableView.backgroundView = nil;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        return 1;
    }
    else
    {
        // Display a message when the table is empty
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];

        messageLabel.text = @"No data is currently available. Please pull down to refresh.";
        messageLabel.textColor = [UIColor blackColor];
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];

        self.tableView.backgroundView = messageLabel;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [messageLabel release];
    }

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return feed.rows.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static const int sTitleHeight = 56;
    static const int sGap = 14;
    static const int sFixedHeight = sTitleHeight + sGap;
    static const int sMinimumHeight = 100;
    static const int sWidth = 230;//only for iphone 4 landscape mode
    
    Row *row = (Row *)[[feed.rows objectAtIndex:indexPath.row] retain];

    UIFont *font = [[UIFont systemFontOfSize:17.0] retain];
    UITextView *calculationView = [[UITextView alloc] init];
    [calculationView setFont:font];
    [calculationView setTextAlignment:NSTextAlignmentLeft];
    [calculationView setText:row.desc];
    CGSize size = [calculationView sizeThatFits:CGSizeMake(sWidth, FLT_MAX)];
    
    [font release];
    [calculationView release];
    [row release];
    
    return sMinimumHeight > size.height ? sMinimumHeight + sFixedHeight : size.height + sFixedHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const CELL_ID = @"NewsFeedCell";
    NewsFeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];

    // Configure the cell...
    Row *row = (Row *)[[feed.rows objectAtIndex:indexPath.row] retain];
    cell.labelTitle.text = row.title;
    cell.labelDesc.text = row.desc;
    cell.imageViewRow.image = nil;// have to clean the image view first

    //when the row has image to load
    if (row.imageHref)
    {
        
        if (imageCache[row.imageHref])
        {
            //when the image is already in the cache, load from the cache
            cell.imageViewRow.image = imageCache[row.imageHref];
        }
        else
        {
            //otherwise, load from network
            NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:row.imageHref]];
            NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
            {
                if (!error)
                {
                    LOG(@"indexPath  = %@", indexPath);
                    UIImage *image = [[UIImage alloc] initWithData:data];
                    if (image)
                    {
                        //save to cache first
                        imageCache[row.imageHref] = image;
                        
                        //only when the row is visiable, load the downloaded image to the cell
                        for (NSIndexPath *index in self.tableView.indexPathsForVisibleRows)
                        {
                            if ((indexPath.section == index.section) && (indexPath.row == index.row))
                            {
                                ((NewsFeedTableViewCell *) [self.tableView cellForRowAtIndexPath:indexPath]).imageViewRow.image = imageCache[row.imageHref];
                            }
                        }
                    }
                }
                else
                {
                    LOG(@"indexPath  = %@   error = %@", indexPath, error);
                }
            }];

            [request release];
            [queue release];
        }
    }

    [row release];
    return cell;
}


@end

