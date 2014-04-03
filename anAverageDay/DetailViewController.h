//
//  DetailViewController.h
//  anAverageDay
//
//  Created by esther on 4/2/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"

@interface DetailViewController : UITableViewController

@property (strong, nonatomic) Entry *entryDetail;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
