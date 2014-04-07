//
//  customNavBar.m
//  anAverageDay
//
//  Created by esther on 4/7/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import "customNavBar.h"

@implementation customNavBar

static CGFloat const kSpaceToCoverStatusBars = 20.0f;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if( self = [super initWithCoder:aDecoder]) {
        [self setTintColor:[UIColor whiteColor]];
        //[self setBarTintColor:[UIColor colorWithRed: 130.0/255.0 green: 0.0 blue: 13.0/255.0 alpha: 0.5f]];
 //       [self setBarTintColor:[UIColor colorWithRed:0.0f green:0.0f blue:90.0f/255.0f alpha:1]];
        [self setBackgroundImage:[UIImage new]
                                 forBarMetrics:UIBarMetricsDefault];
        
        self.shadowImage = [UIImage new];
        self.translucent = YES;
        
        UIColor *navigationBarBackgroundColour = [UIColor colorWithRed:130.0/255.0 green:0.0 blue:13.0/255.0 alpha:1.00f];
        UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0.f, -20.f, 320.f, 64.f)];
        navView.opaque = NO;
        navView.alpha = .9f;
        navView.backgroundColor = navigationBarBackgroundColour;
//        self.barTintColor = navigationBarBackgroundColour;
        
        
        [self.layer insertSublayer:navView.layer atIndex:1];

    }
    return self;
}

- (void)setBarTintColor:(UIColor *)barTintColor {
//    [super setBarTintColor:barTintColor];
    if (self.colorLayer == nil) {
        self.colorLayer = [CALayer layer];
        self.colorLayer.opacity = 0.3;
        [self.layer addSublayer:self.colorLayer];
    }
//    self.colorLayer.backgroundColor = barTintColor.CGColor;
    self.colorLayer.backgroundColor = [UIColor yellowColor].CGColor;//barTintColor.CGColor;
}
/*
- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.colorLayer != nil) {
        self.colorLayer.frame = CGRectMake(0, 0 - kSpaceToCoverStatusBars, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) + kSpaceToCoverStatusBars);
        self.colorLayer.opacity = 0.3;
        
        [self.layer insertSublayer:self.colorLayer atIndex:1];
    }
}
*/
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];

//    [self setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    [self setBarStyle:UIBarStyleBlackTranslucent];
    [self setTranslucent:YES];
    
}
*/
@end
