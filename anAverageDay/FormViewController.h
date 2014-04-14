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
@property (nonatomic, strong) Entry *entry;
@property (nonatomic, strong) NSMutableArray *headers;
@property (nonatomic) CGFloat initialHeight;

@property (strong, nonatomic) IBOutlet UITextField *titleTextField;
@property (strong, nonatomic) IBOutlet UITextField *moodTextField;
@property (strong, nonatomic) IBOutlet UITextField *weatherTextField;
@property (strong, nonatomic) IBOutlet UITextField *locationTextField;
@property (strong, nonatomic) IBOutlet UITextView *foodTextView;
@property (strong, nonatomic) IBOutlet UITextView *tasksTextView;
@property (strong, nonatomic) IBOutlet UITextView *extraTextView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *moodLabel;
@property (strong, nonatomic) IBOutlet UILabel *weatherLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *foodLabel;
@property (strong, nonatomic) IBOutlet UILabel *tasksLabel;
@property (strong, nonatomic) IBOutlet UILabel *extraLabel;

@property (strong, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (strong, nonatomic) IBOutlet UIView *buttonView;

- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
