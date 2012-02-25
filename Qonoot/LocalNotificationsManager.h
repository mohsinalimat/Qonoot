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

-(void)addLocalNotification:(NSString*)round 
               withPrayTime:(PrayTime*)prayTime;

@property (strong,nonatomic) NSMutableArray *notifs;
@property (strong,nonatomic) NSArray *sounds;
@property (strong,nonatomic) NSString *sound;

@end
