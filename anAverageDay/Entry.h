//
//  Entry.h
//  anAverageDay
//
//  Created by esther on 4/2/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject

@property (nonatomic, strong) NSMutableAttributedString *title;
@property (nonatomic, strong) NSMutableAttributedString *mood;
@property (nonatomic, strong) NSMutableAttributedString *weather;

@end
