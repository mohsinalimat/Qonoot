//
//  Friend.h
//  Player
//
//  Created by Sina on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrayTime : NSObject {
    NSString *dayIndex;
    NSString *weekDay;
    NSString *day;
    NSString *month;
    NSString *year;
    NSString *asr;
    NSString *fajr;
    NSString *isha;
    NSString *maghrib;
    NSString *sunrise;
    NSString *zuhr;
}

- (NSString *)dayIndex;
- (NSString *)weekDay;
- (NSString *)day;
- (NSString *)month;
- (NSString *)year;
- (NSString *)asr;
- (NSString *)fajr;
- (NSString *)isha;
- (NSString *)maghrib;
- (NSString *)sunrise;
- (NSString *)zuhr;

- (id)init;

- (void)setDayIndex:(NSString *)input;
- (void)setWeekDay:(NSString *) input;
- (void)setDay:(NSString *)     input;
- (void)setMonth:(NSString *)   input;
- (void)setYear:(NSString *)    input;
- (void)setAsr:(NSString *)     input;
- (void)setFajr:(NSString *)    input;
- (void)setIsha:(NSString *)    input;
- (void)setMaghrib:(NSString *) input;
- (void)setSunrise:(NSString *) input;
- (void)setZuhr:(NSString *)    input;

@end
