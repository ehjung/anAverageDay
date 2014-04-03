//
//  FormViewController.m
//  anAverageDay
//
//  Created by esther on 4/2/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import "FormViewController.h"

@implementation FormViewController

@synthesize delegate;

- (IBAction)cancel:(id)sender {
    [self.delegate formViewControllerDidCancel:self];
}
- (IBAction)save:(id)sender {
    Entry *entry = [[Entry alloc] init];
    entry.title = self.titleTextField.text;
    [self.delegate formViewController:self didAddEntry:entry];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0)
		[self.titleTextField becomeFirstResponder];
}

@end
