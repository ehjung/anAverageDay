//
//  MasterViewController.m
//  anAverageDay
//
//  Created by esther on 4/2/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import "MasterViewController.h"
#import "Entry.h"
#import "EntryViewController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if( self = [super initWithCoder:aDecoder] ) {
        self.appDelegate = [[UIApplication sharedApplication] delegate];
        self.appDelegate.entries = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.appDelegate.entries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MasterViewCell" forIndexPath:indexPath];
    Entry *entry = self.appDelegate.entries[indexPath.row];
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:entry.title attributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:20.0], NSForegroundColorAttributeName:[UIColor colorWithRed:82.0/255.0 green:139.0/255.0 blue:139.0/255.0 alpha:1.0]}];
    
    [self formatThumbnail:entry.thumbnail inCell:cell];
    cell.textLabel.attributedText = title;
    cell.detailTextLabel.text = entry.date;
    
    return cell;
}

- (void)formatThumbnail:(UIImage *)thumbnail inCell:(UITableViewCell *)cell {
    if (thumbnail == nil) {
        cell.imageView.image = [UIImage imageNamed:@"emptyThumbnail.png"];
    } else {
        cell.imageView.image = thumbnail;
    }
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.appDelegate.entries removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showEntryDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        EntryViewController *destViewController = segue.destinationViewController;
        Entry *entry = self.appDelegate.entries[indexPath.row];
        destViewController.entry = entry;
    } else if ([[segue identifier] isEqualToString:@"form"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        FormViewController *formViewController = [[navigationController viewControllers] objectAtIndex:0];
        formViewController.delegate = self;
    }
}

#pragma mark - FormViewControllerDelegate


- (void)formViewController:(FormViewController *)controller didAddEntry:(Entry *)entry {
    [self.appDelegate.entries insertObject:entry atIndex:0];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)formViewControllerDidCancel:(FormViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
