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
    
    entry.title = [self formatString:self.titleTextField.text sectionLabel:@"TITLE "];
    entry.mood = [self formatString:self.moodTextField.text sectionLabel:@"MOOD "];
    entry.weather = [self formatString:self.weatherTextField.text sectionLabel:@"WEATHER "];
    
    [self.delegate formViewController:self didAddEntry:entry];
}

- (NSMutableAttributedString *)formatString:(NSString *)string sectionLabel:(NSString *)sectionLabel {
    if( 0 != string.length ) {
        NSDictionary *labelAttr = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor grayColor], NSForegroundColorAttributeName, nil];
        NSDictionary *stringAttr = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor greenColor], NSForegroundColorAttributeName, nil];
        
        NSMutableAttributedString *attributedLabel = [[NSMutableAttributedString alloc] initWithString:sectionLabel attributes:labelAttr];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string attributes:stringAttr];
        [attributedLabel appendAttributedString:attributedString];
        
        return attributedLabel;
    } else {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
}

- (void)setEntryTitle:(Entry *)entry {
    if( 0 == entry.title.length ) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MMM-dd-yyyy HH:mm:ss a"];
        NSMutableAttributedString *date = [[NSMutableAttributedString alloc] initWithString:[dateFormatter stringFromDate:[NSDate date]]];
        entry.title = date;
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
