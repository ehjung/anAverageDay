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
    self.entry = [[Entry alloc] init];
    [self setEntryTitle:self.entry];
    
    self.entry.title = self.titleTextField.text;
    [self addObject:self.titleTextField.text sectionLabel:@"TITLE "];
    [self addObject:self.moodTextField.text sectionLabel:@"MOOD "];
    [self addObject:self.weatherTextField.text sectionLabel:@"WEATHER "];
    [self addObject:self.locationTextField.text sectionLabel:@"LOCATION "];
    [self addObject:self.breakTextField.text sectionLabel:@"BREAKFAST "];
    [self addObject:self.lunchTextField.text sectionLabel:@"LUNCH "];
    [self addObject:self.dinnerTextField.text sectionLabel:@"DINNER "];
    [self addObject:self.snackTextField.text sectionLabel:@"SNACK "];
    [self addObject:self.extraTextField.text sectionLabel:@"EXTRA "];
    
    [self.delegate formViewController:self didAddEntry:self.entry];
}

- (void)addObject:(NSString *)text sectionLabel:(NSString *)sectionLabel {
    NSAttributedString *formattedString = [self formatString:text sectionLabel:sectionLabel];
    if( 0 != formattedString.length ) {
        [self.entry.content addObject:formattedString];
    }
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
