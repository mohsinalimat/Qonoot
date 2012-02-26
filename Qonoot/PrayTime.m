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
- (NSString *)fajr {
    return fajr;
}
- (NSString *)sunrise {
    return sunrise;
}
- (NSString *)zuhr {
    return zuhr;
}
- (NSString *)asr {
    return asr;
}
- (NSString *)maghrib {
    return maghrib;
}
- (NSString *)isha {
    return isha;
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
- (void)setFajr:(NSString *)input
{
    fajr = input;
}
- (void)setSunrise:(NSString *)input
{
    sunrise = input;
}
- (void)setZuhr:(NSString *)input
{
    zuhr = [self convertTo24:input];
}
- (void)setAsr:(NSString *)input {
    asr = [self convertTo24:input];
}
- (void)setMaghrib:(NSString *)input
{
    maghrib = [self convertTo24:input];
}
- (void)setIsha:(NSString *)input
{
    isha = [self convertTo24:input];
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