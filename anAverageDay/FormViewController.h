//
//  FormViewController.h
//  anAverageDay
//
//  Created by esther on 4/2/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"

@class FormViewController;

@protocol FormViewControllerDelegate <NSObject>

- (void)formViewControllerDidCancel:(FormViewController *)controller;
- (void)formViewController:(FormViewController *)controller didAddEntry:(Entry *)entry;

@end

@interface FormViewController : UITableViewController

@property (nonatomic, weak) id <FormViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextField *breakTextField;
@property (strong, nonatomic) IBOutlet UITextField *lunchTextField;
@property (strong, nonatomic) IBOutlet UITextField *dinnerTextField;
@property (strong, nonatomic) IBOutlet UITextField *snackTextField;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
