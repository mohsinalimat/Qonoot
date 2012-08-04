//
//  Friend.h
//  Player
//
//  Created by Sina on 1/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrayTime : NSObject {
}

@property (strong,nonatomic) NSString *dayIndex;
@property (strong,nonatomic) NSString *weekDay;
@property (strong,nonatomic) NSString *day;
@property (strong,nonatomic) NSString *month;
@property (strong,nonatomic) NSString *year;
@property (strong,nonatomic) NSString *sunrise;
@property (strong,nonatomic) NSString *zuhr;
@property (strong,nonatomic) NSString *asr;
@property (strong,nonatomic) NSString *fajr;
@property (strong,nonatomic) NSString *maghrib;
@property (strong,nonatomic) NSString *isha;
@property (strong,nonatomic) NSMutableArray *notificationsOn;

- (id)init;

@end
