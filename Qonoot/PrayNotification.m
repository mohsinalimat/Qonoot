//
//  PrayNotification.m
//  Ghonoot
//
//  Created by Sina on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayNotification.h"

@implementation PrayNotification

@synthesize name = _name;
@synthesize round = _round;
@synthesize time = _time;
@synthesize date = _date;

- (id)init {
    if (self = [super init]) {
        //[self setDayIndex:@"-1"];
    }
    return self;
}

- (NSString *)name{
    if (!_name) _name = @"";
    return _name;
}

- (NSString *)round{
    if (!_round) _round = @"";
    return _round;
}

- (NSString *)time{
    if (!_time) _time = @"";
    return _time;
}

- (NSString *)date{
    if (!_date) _date = @"";
    return _date;
}

@end
