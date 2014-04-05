//
//  EntryViewController.m
//  anAverageDay
//
//  Created by esther on 4/5/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import "EntryViewController.h"

@interface EntryViewController ()

@end

static NSString * entryCellIdentifier = @"entryCell";

@implementation EntryViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if( self = [super initWithCoder:aDecoder] ) {
        self.appDelegate = [[UIApplication sharedApplication] delegate];
    }
    return self;
}
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.appDelegate = [[UIApplication sharedApplication] delegate];
    }
    return self;
}
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    Entry *entry = [self.appDelegate.entries objectAtIndex:0];
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.scrollView = [[UIScrollView alloc] initWithFrame:frame];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    textView.text = entry.detail;
    textView.editable = NO;
    
    [self.scrollView addSubview:textView];
    [self.scrollView reloadInputViews];
    [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue destinationViewController];
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end