//
//  Friend.m
//  Player
//
//  Created by Sina on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayTime.h"
@implementation PrayTime
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

- (NSString *)dayIndex {
    return dayIndex;
}
- (NSString *)weekDay {
    return weekDay;
}
- (NSString *)day {
    return day;
}
- (NSString *)month {
    return month;
}
- (NSString *)year {
    return year;
}
- (NSString *)asr {
    return asr;
}
- (NSString *)fajr {
    return fajr;
}
- (NSString *)isha {
    return isha;
}
- (NSString *)maghrib {
    return maghrib;
}
- (NSString *)sunrise {
    return sunrise;
}
- (NSString *)zuhr {
    return zuhr;
}

- (void)setDayIndex:(NSString *)input {
    dayIndex = input;
}
- (void)setWeekDay:(NSString *)input{
    weekDay = input;
}
- (void)setDay:(NSString *)input {
    day = input;
}
- (void)setMonth:(NSString *)input {
    month = input;
}
- (void)setYear:(NSString *)input {
    year = input;
}
- (void)setAsr:(NSString *)input {
    asr = input;
}
- (void)setFajr:(NSString *)input
{
    fajr = input;
}
- (void)setIsha:(NSString *)input
{
    isha = input;
}
- (void)setMaghrib:(NSString *)input
{
    maghrib = input;
}
- (void)setSunrise:(NSString *)input
{
    sunrise = input;
}
- (void)setZuhr:(NSString *)input
{
    zuhr = input;
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