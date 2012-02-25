//
//  PrayDayItemViewController.h
//  Ghonoot
//
//  Created by Sina on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrayTime.h"

@class PrayDayView;

@protocol PrayDayDataSource
- (PrayTime*) myData:(PrayDayView *)sender;
@end

@interface PrayDayView : UIView
@property (nonatomic, strong) NSNumber *dayID;
@property int num;
@property (nonatomic, weak) IBOutlet id <PrayDayDataSource> dataSource;

@end
