//
//  TestViewController.h
//  Qonoot
//
//  Created by Sina on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrayTime.h"

@class TestViewController;

@protocol PrayDayDataSource
- (PrayTime*) myData:(TestViewController *)sender;
@end

@interface TestViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *dayOftheWeekLabel;
@property (nonatomic, strong) NSNumber *dayID;
@property int num;
@property (nonatomic, weak) IBOutlet id <PrayDayDataSource> dataSource;
@property (weak, nonatomic) IBOutlet UILabel *fajrLabel;
@property (weak, nonatomic) IBOutlet UILabel *sunriseLabel;
@property (weak, nonatomic) IBOutlet UILabel *zuhrLabel;
@property (weak, nonatomic) IBOutlet UILabel *asrLabel;
@property (weak, nonatomic) IBOutlet UILabel *maghribLabel;
@property (weak, nonatomic) IBOutlet UILabel *ishaLabel;

@end
