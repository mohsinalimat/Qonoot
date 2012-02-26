//
//  LocalNotificationsManager.h
//  Ghonoot
//
//  Created by Sina on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrayNotification.h"
#import "PrayTime.h"

@interface LocalNotificationsManager : NSObject
{
    NSString *sound;
}

-(void)addLocalNotification:(NSString*)round 
               withPrayTime:(PrayTime*)prayTime;

-(NSArray*)getAllNotifications;
-(void)cancelAllNotifications;
-(void)cancelNotification:(NSString*)name;

+ (id)sharedManager;

@property (strong,nonatomic) NSMutableArray *notifs;
@property (strong,nonatomic) NSArray *sounds;
@property (nonatomic, retain) NSString *sound;

@end