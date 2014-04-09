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
#import "FXBlurView.h"

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

- (void)viewWillAppear:(BOOL)animated {
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
/*
    CALayer *colourLayer = [CALayer layer];
    colourLayer.backgroundColor = [UIColor colorWithRed: 130.0/255.0 green: 0.0 blue: 13.0/255.0 alpha: 1.0].CGColor;
    colourLayer.opacity = 0.2f;
    colourLayer.frame = CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height);
 */
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"red2.png"] forBarMetrics:UIBarMetricsDefault];

    FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height + 20)];
    blurView.underlyingView = self.tableView;
    blurView.tintColor = [UIColor clearColor];
    blurView.updateInterval = 0.01;
    [blurView setDynamic:YES];
    blurView.blurRadius = 10;
    blurView.alpha = 1.0f;
    
    [self.navigationController.navigationBar.superview insertSubview:blurView belowSubview:self.navigationController.navigationBar];
    //[self.navigationController.navigationBar.layer addSublayer:colourLayer];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Entry *entry = self.appDelegate.entries[indexPath.row];
    cell.textLabel.text = entry.title;
    cell.imageView.image = [UIImage imageNamed:@"images.png"];
    
//    UIToolbar* bgToolbar = [[UIToolbar alloc] initWithFrame:cell.frame];
//    [cell.superview addSubview:bgToolbar];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
