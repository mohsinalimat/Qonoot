//
//  PrayTimesModel.h
//  Qonoot
//
//  Created by Sina on 7/28/12.
//
//

#import <Foundation/Foundation.h>

@interface PrayTimesModel : NSObject

-(void)addPrayTime:(id)object;
+ (id)sharedManager;

@property (nonatomic) int currentGroup;
@property (strong,nonatomic) NSString* currentGroupName;

@property (strong,nonatomic) NSMutableArray *objects;

@end