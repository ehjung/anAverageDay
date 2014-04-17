//
//  EntryViewController.m
//  anAverageDay
//
//  Created by esther on 4/6/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import "EntryViewController.h"

@interface EntryViewController ()

@end

static NSString * entryCellIdentifier = @"EntryCell";

@implementation EntryViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if( self = [super initWithCoder:aDecoder] ) {
        self.appDelegate = [[UIApplication sharedApplication] delegate];
        self.entry = [[Entry alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.entry.content count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:entryCellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:entryCellIdentifier];
    }
    
    NSMutableAttributedString *entryDetail = [self.entry.content objectAtIndex:indexPath.section];
    cell.textLabel.attributedText = entryDetail;

    return cell;
}

@end
