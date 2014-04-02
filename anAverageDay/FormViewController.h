//
//  FormViewController.h
//  anAverageDay
//
//  Created by esther on 4/2/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FormViewController;

@protocol FormViewControllerDelegate <NSObject>

- (void)formViewControllerDidCancel:(FormViewController *)controller;
- (void)formViewControllerDidSave:(FormViewController *)controller;

@end

@interface FormViewController : UITableViewController

@property (nonatomic, weak) id <FormViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
