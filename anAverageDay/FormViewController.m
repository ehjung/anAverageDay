//
//  FormViewController.m
//  anAverageDay
//
//  Created by esther on 4/2/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import "FormViewController.h"
#import "CameraViewController.h"

@implementation FormViewController

@synthesize delegate;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.photoImageView = [[UIImageView alloc] init];
    }
    return self;
}

- (IBAction)cancel:(id)sender {
    [self.delegate formViewControllerDidCancel:self];
}
- (IBAction)save:(id)sender {
    self.entry = [[Entry alloc] init];
    
    self.entry.title = self.titleTextField.text;
    self.entry.date = [self getDateWithTime:NO];
    if (self.photoImageView.image != nil) {
        self.entry.thumbnail = [FormViewController scaleThenCropImage:self.photoImageView.image targetHeight:90 targetWidth:90];
    }
    self.entry.photo = self.photoImageView.image;
    
    [self addObject:self.titleTextField.text sectionLabel:@"TITLE "];
    [self addObject:[self getDateWithTime:YES] sectionLabel:@"DATE "];
    [self addObject:self.moodTextField.text sectionLabel:@"MOOD "];
    [self addObject:self.weatherTextField.text sectionLabel:@"WEATHER "];
    [self addObject:self.locationTextField.text sectionLabel:@"LOCATION "];
    [self addObject:self.foodTextView.text sectionLabel:@"FOOD CONSUMED "];
    [self addObject:self.tasksTextView.text sectionLabel:@"TASKS COMPLETED"];
    [self addObject:self.extraTextView.text sectionLabel:@"EXTRA "];
    
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
        NSDictionary *labelAttr = @{ NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue" size:12.0], NSForegroundColorAttributeName:[UIColor colorWithRed:82.0/255.0 green:139.0/255.0 blue:139.0/255.0 alpha:1.0]};
        NSDictionary *stringAttr = @{ NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:16.0]};
        
        NSMutableAttributedString *attributedLabel = [[NSMutableAttributedString alloc] initWithString:sectionLabel attributes:labelAttr];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string attributes:stringAttr];
        [attributedLabel appendAttributedString:attributedString];
        
        return attributedLabel;
    } else {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
}

- (NSString *)getDateWithTime:(BOOL)needTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (needTime == YES) {
        [dateFormatter setDateFormat:@"MMM-dd-yyyy HH:mm:ss a"];
    } else {
        [dateFormatter setDateFormat:@"MMM dd yyyy"];
    }
    NSString *date = [dateFormatter stringFromDate:[NSDate date]];
    return date;
}

#pragma mark - view and keyboard

- (void)viewDidLoad {
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0]} forState:UIControlStateNormal];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Thin" size:20.0]} forState:UIControlStateNormal];

    [self formatTextView:self.foodTextView];
    [self formatTextView:self.tasksTextView];
    [self formatTextView:self.extraTextView];
    [self formatPhotoView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
    self.keyboardIsShown = NO;
    CGSize scrollContentSize = CGSizeMake(320, 345);
    self.tableView.contentSize = scrollContentSize;
}

- (void)formatPhotoView {
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    CAShapeLayer *border = [[CAShapeLayer alloc] init];
    border.strokeColor = [[UIColor grayColor] CGColor];
    border.fillColor = nil;
    border.lineDashPattern = @[@4, @2];
    border.lineWidth = 0.5;
    border.path = [[UIBezierPath bezierPathWithRoundedRect:CGRectMake((screenWidth - 280)/2 , 10, 280, 180) cornerRadius:5] CGPath];
    
    [self.photoView.layer addSublayer:border];
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect viewFrame = self.tableView.frame;
    viewFrame.size.height += (keyboardSize.height);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.tableView setFrame:viewFrame];
    [UIView commitAnimations];

    self.keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    if (self.keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGRect viewFrame = self.tableView.frame;
    viewFrame.size.height -= (keyboardSize.height);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self.tableView setFrame:viewFrame];
    [UIView commitAnimations];
    
    self.keyboardIsShown = YES;
}

# pragma mark - Cell formatting

- (void)formatTextView:(UITextView *)textView {
    [textView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [textView.layer setBorderWidth:0.5];
    textView.layer.cornerRadius = 10;
}

- (void)formatLabel:(UILabel *)label {
    [label setFont:[UIFont fontWithName:@"Helvetica Light" size:12.0]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, 20.0);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    UILabel *header = [[UILabel alloc] initWithFrame:frame];
    
    NSDictionary *textFormat = @{ NSFontAttributeName:[UIFont fontWithName:@"Helvetica Neue" size:12.0], NSForegroundColorAttributeName:[UIColor whiteColor], NSBackgroundColorAttributeName:[UIColor colorWithRed:82.0/255.0 green:139.0/255.0 blue:139.0/255.0 alpha:1.0]};
    header.attributedText = [[NSMutableAttributedString alloc] initWithString:@"         DETAILS  " attributes:textFormat];
    header.backgroundColor = [UIColor whiteColor];
    
    [view addSubview:header];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= 4) {
        return 105;
    } else {
        return 60;
    }
}

#pragma mark - image resizing

+ (UIImage *)scaleThenCropImage:(UIImage *)image targetHeight:(CGFloat)targetHeight targetWidth:(CGFloat)targetWidth {
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat scaleFactor;
    CGSize targetSize = CGSizeMake(targetWidth, targetHeight);
    
    CGFloat widthFactor = targetWidth / width;
    CGFloat heightFactor = targetHeight / height;
    if (widthFactor > heightFactor) {
        scaleFactor = widthFactor;
    } else {
        scaleFactor = heightFactor;
    }
    
    CGFloat scaledWidth = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    CGPoint thumbnailPoint = CGPointMake(0, 0);
    if (widthFactor > heightFactor)
    {
        thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
    }
    else
    {
        if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledWidth, scaledHeight);
    [image drawInRect:thumbnailRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - segue

- (IBAction)unwindToFormViewController:(UIStoryboardSegue *)unwindSegue {
    CameraViewController *sourceViewController = [unwindSegue sourceViewController];
    self.photoImageView = sourceViewController.imageView;
    [self.photoImageView setCenter:CGPointMake(self.photoView.frame.size.width/2, self.photoView.frame.size.height/2 - 3.5)];
    self.photoImageView.layer.cornerRadius = 10;
    self.photoImageView.clipsToBounds = YES;
    [self.photoView addSubview:self.photoImageView];
}

@end
