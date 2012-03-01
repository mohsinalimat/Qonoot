//
//  LocalNotificationsManager.m
//  Ghonoot
//
//  Created by Sina on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocalNotificationsManager.h"

static LocalNotificationsManager *sharedMyManager = nil;

@implementation LocalNotificationsManager

@synthesize notifs = _notifs;
@synthesize sounds = _sounds;
@synthesize sound = _sound;

#pragma mark Singleton Methods
+ (id)sharedManager {
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}
- (id)init {
    if (self = [super init]) {
        //sound = [[NSString alloc] initWithString:@"Default Property Value"];
    }
    return self;
}

- (NSArray *)sounds
{
    if (!_sounds) _sounds = [NSArray arrayWithObjects:@"Default", @"Azoon 1", nil];
    return _sounds;
}

-(void)setSound:(NSString *)soundName
{
    _sound = soundName;
    
    NSArray *array = [self getAllNotifications];
    for (int i = 0; i < [array count]; i++) {
        
        UILocalNotification *notification = [array objectAtIndex:i];
        [notification setSoundName:[NSString stringWithFormat:@"%@%@", soundName, @".wav"]];
    }
}

- (NSString *)sound
{
    if (!_sound) _sound = @"Default";
    return _sound;
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
    
    NSDate *now = [NSDate date];
    NSComparisonResult compare = [dateToFire compare:now];
    
    //NSDate *date = [NSDate date];
    //NSDate *dateToFire = [date dateByAddingTimeInterval:10];
    
    if(compare == 1)
    {
        NSLog(@"dateToFire :%@", dateToFire);
        
        [localNotification setFireDate:dateToFire];
        [localNotification setTimeZone:[NSTimeZone defaultTimeZone]];
        
        NSString *message = [NSString stringWithFormat:@"%@%@%@", 
                             newNotif.round,
                             @" ",
                             newNotif.time];
        NSMutableDictionary *data = [NSMutableDictionary dictionaryWithObject:message forKey:@"message"];
        [data setValue:newNotif.round forKey:@"round"];
        
        [localNotification setUserInfo:data];
        
        [localNotification setAlertBody:@"Prayer Time Reminder" ];
        //[localNotification setAlertAction:@"Open"];
        //[localNotification setHasAction:YES];
        
        //[localNotification setApplicationIconBadgeNumber:[[UIApplication sharedApplication] applicationIconBadgeNumber] + 1];
        [localNotification setSoundName:[NSString stringWithFormat:@"%@%@", self.sound, @".wav"]];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    }    
}

-(NSArray*)getAllNotifications
{
    NSArray *array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"---------getNotifications-------");
    for (int i = 0; i < [array count]; i++) {
        
        UILocalNotification *notification = [array objectAtIndex:i];
        NSString *message = [notification.userInfo valueForKey:@"message"];
        NSString *round = [notification.userInfo valueForKey:@"round"];
        NSLog(@"Messa: %@", message);
        NSLog(@"Round: %@", round);
        NSLog(@"----------");
    }
    NSLog(@"--------------------------------");
    
    return array;
}

-(void)cancelNotification:(NSString*)name
{
    NSArray *array = [[UIApplication sharedApplication] scheduledLocalNotifications];
    NSLog(@"---------cancelNotification-------");
    for (int i = 0; i < [array count]; i++) {
        
        UILocalNotification *notification = [array objectAtIndex:i];
        NSString *round = [notification.userInfo valueForKey:@"round"];
        if([round isEqualToString:name])
        {
            [[UIApplication sharedApplication] cancelLocalNotification:notification];
            NSLog(@"notification: %@%@", name, @" successfully cancelled!");
        }
    }
    NSLog(@"--------------------------------");
}

-(void)cancelAllNotifications
{
    NSLog(@"---------cancelAllNotifications-------");
    NSLog(@"--------------------------------");
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

@end
