//
//  EntryViewController.h
//  anAverageDay
//
//  Created by esther on 4/6/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"
#import "AppDelegate.h"

@interface EntryViewController : UITableViewController

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) Entry *entry;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end
