//
//  MasterViewController.h
//  anAverageDay
//
//  Created by esther on 4/2/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormViewController.h"
#import "AppDelegate.h"

@interface MasterViewController : UITableViewController <FormViewControllerDelegate>

@property (nonatomic, strong) AppDelegate* appDelegate;

@end
