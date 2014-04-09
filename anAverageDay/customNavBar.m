//
//  customNavBar.m
//  anAverageDay
//
//  Created by esther on 4/7/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import "customNavBar.h"
#import "FXBlurView.h"

@implementation customNavBar

- (id)initWithCoder:(NSCoder *)aDecoder {
    if( self = [super initWithCoder:aDecoder]) {

        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        self.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
        [self setTintColor:[UIColor whiteColor]];
//        [self setBarTintColor:[UIColor colorWithRed: 130.0/255.0 green: 0.0 blue: 13.0/255.0 alpha: 1.0f]];
        /*
        FXBlurView *blurView = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height + 20)];
        blurView.underlyingView = self.superview;
        blurView.tintColor = [UIColor clearColor];
        blurView.updateInterval = 0.01;
        [blurView setDynamic:YES];
        blurView.blurRadius = 10;
        blurView.alpha = 1.0f;
        
        [self.superview insertSubview:blurView belowSubview:self];
        
*/
 //       [self setBarTintColor:[UIColor colorWithRed:0.0f green:0.0f blue:90.0f/255.0f alpha:1]];
    }
    return self;
}

- (void)setBarTintColor:(UIColor *)barTintColor {
//    [super setBarTintColor:barTintColor];
    if( self.colorLayer == nil ) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.colorLayer = [CALayer layer];
        self.colorLayer.opacity = 0.8;
        self.colorLayer.backgroundColor = barTintColor.CGColor;
        self.colorLayer.frame = self.frame;
        [self.layer addSublayer:self.colorLayer];
    }
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
