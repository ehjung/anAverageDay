//
//  DetailViewController.m
//  anAverageDay
//
//  Created by esther on 4/2/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder]))
	{
		NSLog(@"init PlayerDetailsViewController");
	}
	return self;
}
- (void)dealloc
{
	NSLog(@"dealloc PlayerDetailsViewController");
}

#pragma mark - Managing the detail item

- (void)setEntryDetail:(Entry *)newEntryDetail
{
    if (_entryDetail != newEntryDetail) {
        _entryDetail = newEntryDetail;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if( self.entryDetail ) {
//        self.detailDescriptionLabel.text = self.entryDetail.title;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
