//
//  Entry.h
//  anAverageDay
//
//  Created by esther on 4/2/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSMutableArray *content;
@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) UIImage *photo;

@end
