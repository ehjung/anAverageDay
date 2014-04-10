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
    //[self setEntryTitle:self.entry];
    
    self.entry.title = self.titleTextField.text;
    [self addObject:self.titleTextField.text sectionLabel:@"TITLE "];
    [self addObject:[self getDate] sectionLabel:@"DATE "];
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
        NSDictionary *labelAttr = @{ NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue" size:12.0], NSForegroundColorAttributeName:[UIColor grayColor]};
        NSDictionary *stringAttr = @{ NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:16.0]};
        
        NSMutableAttributedString *attributedLabel = [[NSMutableAttributedString alloc] initWithString:sectionLabel attributes:labelAttr];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string attributes:stringAttr];
        [attributedLabel appendAttributedString:attributedString];
        
        return attributedLabel;
    } else {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
}

- (NSString *)getDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM-dd-yyyy HH:mm:ss a"];
    NSString *date = [dateFormatter stringFromDate:[NSDate date]];
    return date;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView setBackgroundColor:[UIColor colorWithRed:205.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1.0]];
    
    self.headers = [NSMutableArray arrayWithObjects:@"  TITLE", @"  MOOD", @"  WEATHER", @"  LOCATION", @"  FOOD CONSUMED", @"  EXTRA MUNDANE STUFF", nil];
    
    self.takePhotoButton.layer.cornerRadius = 5;
    self.takePhotoButton.layer.borderWidth = 1;
    self.takePhotoButton.layer.borderColor = [UIColor colorWithRed:61.0/255.0 green:89.0/255.0 blue:171.0/255.0 alpha:1.0].CGColor;
    [self.takePhotoButton setTitleColor:[UIColor colorWithRed:61.0/255.0 green:89.0/255.0 blue:171.0/255.0 alpha:1.0] forState:UIControlStateNormal];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, 20.0);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    UILabel *header = [[UILabel alloc] initWithFrame:frame];
    
    NSDictionary *textFormat = @{ NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue" size:12.0], NSForegroundColorAttributeName:[UIColor whiteColor]};
    header.attributedText = [[NSMutableAttributedString alloc] initWithString:[self.headers objectAtIndex:section] attributes:textFormat];
    
    [view addSubview:header];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0) {
		[self.titleTextField becomeFirstResponder];
    }
}



@end
