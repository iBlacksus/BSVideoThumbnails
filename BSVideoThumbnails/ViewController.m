//
//  ViewController.m
//  BSVideoThumbnails
//
//  Created by iBlacksus on 10/13/14.
//  Copyright (c) 2014 Borodutch Studio. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+CellFromClass.h"
#import "BSVideoCell.h"
#import "BSVideoObject.h"
#import "SDImageCache.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSArray *data;

- (IBAction)clear:(id)sender;

@end

@implementation ViewController

#pragma mark - Life cycle -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self subscribeForNotifications];
    [self updateCacheSize];
    
    // example video from Instagram
    self.data = @[[BSVideoObject objectWithURL:@"http://distilleryvesper9-13.ak.instagram.com/090d06dad9cd11e2aa0912313817975d_102.mp4"],
                  [BSVideoObject objectWithURL:@"http://videos-h-17.ak.instagram.com/hphotos-ak-xfa1/10724357_372216016268637_1023198378_n.mp4"],
                  [BSVideoObject objectWithURL:@"http://videos-g-10.ak.instagram.com/hphotos-ak-xfa1/10715267_290542781139010_2070196885_n.mp4"],
                  [BSVideoObject objectWithURL:@"http://videos-f-15.ak.instagram.com/hphotos-ak-xaf1/10705926_285088118362675_1593168660_n.mp4"],
                  [BSVideoObject objectWithURL:@"http://videos-f-7.ak.instagram.com/hphotos-ak-xaf1/10687665_778680448853227_1154722815_n.mp4"]];
}

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [BSVideoCell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellFromClass:[BSVideoCell class] withObject:self.data[indexPath.row]];
}

#pragma mark - Actions -

- (IBAction)clear:(id)sender
{
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDImageCache sharedImageCache] clearDisk];
    
    [self updateCacheSize];
    [self.tableView reloadData];
}

#pragma mark - General methods -

- (void)subscribeForNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCacheSize) name:newImageInCacheNotification object:nil];
}

- (void)updateCacheSize
{
    [[SDImageCache sharedImageCache] calculateSizeWithCompletionBlock:^(NSUInteger fileCount, NSUInteger totalSize) {
        self.navigationItem.title = [NSByteCountFormatter stringFromByteCount:totalSize countStyle:NSByteCountFormatterCountStyleFile];
    }];
}

@end
