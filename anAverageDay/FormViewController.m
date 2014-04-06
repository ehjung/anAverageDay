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
    [self setEntryTitle:entry];
    entry.detail = entry.title;
    entry.detail = [entry.detail stringByAppendingString: self.moodTextField.text];
    entry.detail = [entry.detail stringByAppendingString: self.weatherTextField.text];
    entry.detail = [entry.detail stringByAppendingString: self.locationTextField.text];
    entry.detail = [entry.detail stringByAppendingString: self.breakTextField.text];
    entry.detail = [entry.detail stringByAppendingString: self.lunchTextField.text];
    entry.detail = [entry.detail stringByAppendingString: self.dinnerTextField.text];
    entry.detail = [entry.detail stringByAppendingString: self.snackTextField.text];
    entry.detail = [entry.detail stringByAppendingString: self.extraTextField.text];
    
    [self.delegate formViewController:self didAddEntry:entry];
}

- (void)setEntryTitle:(Entry *)entry {
    if( 0 == entry.title.length ) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM-dd-yyyy HH:mm:ss a"];
        entry.title = [dateFormatter stringFromDate:[NSDate date]];
    }
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		[self.titleTextField becomeFirstResponder];
    }
}

@end
