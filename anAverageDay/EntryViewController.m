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
    
    if (self.entry.photo == nil) {
        self.imageView.image = [UIImage imageNamed:@"emptyPhoto.png"];
    } else {
        self.imageView.image = self.entry.photo;
    }
    
    self.imageView.layer.cornerRadius = 10;
    self.imageView.clipsToBounds = YES;
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
