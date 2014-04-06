//
//  Entry.m
//  anAverageDay
//
//  Created by esther on 4/2/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import "Entry.h"

@implementation Entry

- (id)init {
    if( self = [super init] ) {
        self.content = [[NSMutableArray alloc] init];
    }
    return self;
}

@end
