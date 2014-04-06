//
//  EntryViewController.h
//  anAverageDay
//
//  Created by esther on 4/5/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Entry.h"

@interface EntryViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) AppDelegate *appDelegate;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic) CGFloat yPosition;

@end
