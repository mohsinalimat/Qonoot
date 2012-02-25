//
//  LocalNotificationsManager.m
//  Ghonoot
//
//  Created by Sina on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalNotificationsManager.h"

@implementation LocalNotificationsManager

@synthesize notifs = _notifs;
@synthesize sounds = _sounds;

- (NSArray *)sounds
{
    if (!_sounds) _sounds = [NSArray arrayWithObjects:@"Default", @"Azoon 1", nil];
    return _sounds;
}


- (NSMutableArray *)notifs
{
    if (!_notifs) _notifs = [[NSMutableArray alloc] init];
    return _notifs;
}

-(void)addLocalNotification:(NSString*)round 
               withPrayTime:(PrayTime*)prayTime
{
    PrayNotification *newNotif = [[PrayNotification alloc] init];
    [newNotif setName:@"Name"];
    if([round isEqualToString:@"asr"])
        [newNotif setTime:prayTime.asr];
    else if([round isEqualToString:@"zuhr"])
        [newNotif setTime:prayTime.zuhr];
    else if([round isEqualToString:@"isha"])
        [newNotif setTime:prayTime.isha];
    else if([round isEqualToString:@"maghrib"])
        [newNotif setTime:prayTime.maghrib];
    else if([round isEqualToString:@"sunrise"])
        [newNotif setTime:prayTime.sunrise];
    else if([round isEqualToString:@"fajr"])
        [newNotif setTime:prayTime.fajr];
    else
        [newNotif setTime:prayTime.asr];
    [newNotif setRound:round];
    [newNotif setDate:prayTime.year];
    [self.notifs addObject:newNotif];
     
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
	
	if (!localNotification) 
        return;
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    [comps setYear:[prayTime.year intValue]];
    [comps setMonth:[prayTime.month intValue]];
    [comps setDay:[prayTime.day intValue]];
    
    NSRange match = [newNotif.time rangeOfString: @":"];
    NSString *hour = [newNotif.time substringWithRange: NSMakeRange (0, match.location)];
    NSString *minute = [newNotif.time substringWithRange: NSMakeRange (match.location+1, [newNotif.time length]-match.location-1)];
    
    [comps setHour:[hour intValue]];
    [comps setMinute:[minute intValue]];
    [comps setSecond:0];
    
    [comps setTimeZone:[NSTimeZone localTimeZone]];
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *dateToFire = [cal dateFromComponents:comps];
    
    //NSDate *date = [NSDate date];
    //NSDate *dateToFire = [date dateByAddingTimeInterval:10];
    
    NSLog(@"dateToFire :%@", dateToFire);
    
 	[localNotification setFireDate:dateToFire];
    [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
    
    NSString *message = [NSString stringWithFormat:@"%@%@%@", 
                         newNotif.round,
                         @" ",
                         newNotif.time];
    NSDictionary *data = [NSDictionary dictionaryWithObject:message forKey:@"time"];
    [localNotification setUserInfo:data];
    
    [localNotification setAlertBody:@"Prayer Time Reminder" ];
    //[localNotification setAlertAction:@"Open"];
    //[localNotification setHasAction:YES];
    
    [localNotification setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber] + 1];
    
    [localNotification setSoundName:UILocalNotificationDefaultSoundName];
    
	[[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
    NSArray *array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"Number of Notifs: %i", [array count]);
}

@end
