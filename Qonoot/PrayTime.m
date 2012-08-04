//
//  Friend.m
//  Player
//
//  Created by Sina on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayTime.h"
@implementation PrayTime

@synthesize dayIndex;
@synthesize weekDay;
@synthesize day;
@synthesize month;
@synthesize year;
@synthesize asr;
@synthesize fajr;
@synthesize isha;
@synthesize maghrib;
@synthesize sunrise;
@synthesize zuhr;

- (id)init {
    if (self = [super init]) {
        [self setDayIndex:@"-1"];
        [self setWeekDay:@"WeekDay"];
        [self setDay:@"Day"];
        [self setMonth:@"Month"];
        [self setYear:@"Year"];
        [self setAsr:@"Asr"];
        [self setFajr:@"Fajr"];
        [self setIsha:@"Isha"];
        [self setMaghrib:@"Maghrib"];
        [self setSunrise:@"Sunrise"];
        [self setZuhr:@"Zuhr"];
    }
    return self;
}

- (NSString*)convertTo24:(NSString*)original
{
    NSString* converted;
    if ([original rangeOfString:@":"].location != NSNotFound) 
    {
        NSRange match = [original rangeOfString: @":"];

        NSString *hourString = [original substringWithRange: NSMakeRange (0, match.location)];
        NSString *minString = [original substringWithRange: NSMakeRange (match.location+1, [original length]-match.location-1)];
        int hourInt = [hourString intValue];
        
        if(hourInt < 12)
            hourInt = hourInt + 12;
    
        converted = [NSString stringWithFormat:@" %i%@%@", hourInt, @":", minString];
    }
    
    return converted;
}

/* This code has been added to support encoding and decoding my objecst */

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.asr forKey:@"asr"];
    [encoder encodeObject:self.fajr forKey:@"fajr"];
    [encoder encodeObject:self.isha forKey:@"isha"];
    [encoder encodeObject:self.maghrib forKey:@"maghrib"];
    [encoder encodeObject:self.sunrise forKey:@"sunrise"];
    [encoder encodeObject:self.zuhr forKey:@"zuhr"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.asr = [decoder decodeObjectForKey:@"asr"];
    }
    return self;
}

-(void)dealloc {
    
}
@end