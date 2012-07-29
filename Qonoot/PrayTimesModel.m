//
//  PrayTimesModel.m
//  Qonoot
//
//  Created by Sina on 7/28/12.
//
//

#import "PrayTimesModel.h"

@implementation PrayTimesModel

@synthesize objects = _objects;

-(NSMutableArray*)objects
{
    if(!_objects){
        _objects = [NSMutableArray array];
    }
    return _objects;
}

-(void)setObjects:(NSMutableArray *)objects
{
    _objects = objects;
}

static PrayTimesModel *sharedMyManager = nil;
#pragma mark Singleton Methods
+ (id)sharedManager {
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

-(void)addPrayTime:(id)object
{
    [self.objects addObject:object];
}

@end