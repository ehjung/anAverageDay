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

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardDidHideNotification object:nil];
    }
    return self;
}
/*
-(void) keyboardShown:(NSNotification*) notification {
    self.initialHeight = self.tableView.frame.size.height;
    
    CGRect initialFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect convertedFrame = [self.view convertRect:initialFrame fromView:nil];
    CGRect tableFrame = self.tableView.frame;
    tableFrame.size.height = convertedFrame.origin.y;
    self.tableView.frame = tableFrame;
}

-(void) keyboardHidden:(NSNotification*) notification {
    CGRect tableFrame = self.tableView.frame;
    tableFrame.size.height = self.initialHeight;
    [UIView beginAnimations:@"TableViewDown" context:NULL];
    [UIView setAnimationDuration:0.3f];
    self.tableView.frame = tableFrame;
    [UIView commitAnimations];
}

-(void) scrollToCell:(NSIndexPath*) path {
    [self.tableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

-(void) textFieldDidBeginEditing:(UITextField *)textField {
    NSIndexPath* path = [NSIndexPath indexPathForRow:row inSection:section];
    [self performSelector:@selector(scrollToCell:) withObject:path afterDelay:0.5f];
}
*/
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
    [self addObject:self.foodTextField.text sectionLabel:@"FOOD "];
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
    
    self.headers = [NSMutableArray arrayWithObjects:@"  TITLE", @"  MOOD", @"  WEATHER", @"  LOCATION", @"  FOOD CONSUMED", @"  EXTRA MUNDANE STUFF", nil];
    
    self.takePhotoButton.layer.cornerRadius = 5;
    self.takePhotoButton.layer.borderWidth = 1;
    self.takePhotoButton.layer.borderColor = [UIColor colorWithRed:61.0/255.0 green:89.0/255.0 blue:171.0/255.0 alpha:1.0].CGColor;
    [self.takePhotoButton setTitleColor:[UIColor colorWithRed:61.0/255.0 green:89.0/255.0 blue:171.0/255.0 alpha:1.0] forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [self.tableView setBackgroundColor:[UIColor colorWithRed:205.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1.0]];
    [self formatLabel:self.titleLabel text:@"TITLE"];
    [self formatLabel:self.moodLabel text:@"MOOD"];
    [self formatLabel:self.weatherLabel text:@"WEATHER"];
    [self formatLabel:self.locationLabel text:@"LOCATION"];
    [self formatLabel:self.foodLabel text:@"FOOD CONSUMED"];
    [self formatLabel:self.tasksLabel text:@"TASKS COMPLETED"];
    [self formatLabel:self.extraLabel text:@"EXTRA MUNDANE STUFF"];
    
    [self.titleTextField setBackgroundColor:[UIColor grayColor]];
}

- (void)formatLabel:(UILabel *)label text:(NSString *)text {
    label.text = text;
    [label setFont:[UIFont fontWithName:@"Helvetica Light" size:12.0]];
    [label.text uppercaseString];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4 || indexPath.row == 5) {
        return 100;
    } else {
        return 100;
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
