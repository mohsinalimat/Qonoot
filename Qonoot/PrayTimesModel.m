//
//  PrayTimesModel.m
//  Qonoot
//
//  Created by Sina on 7/28/12.
//
//

#import "PrayTimesModel.h"

@implementation PrayTimesModel

static PrayTimesModel *sharedMyManager = nil;
#pragma mark Singleton Methods
+ (id)sharedManager {
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

-(void)removeGroup:(int)index
{
    
}

@end