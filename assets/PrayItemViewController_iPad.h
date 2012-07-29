//
//  TestViewController.h
//  Qonoot
//
//  Created by Sina on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PrayTime.h"

@class PrayItemViewController_iPad;

@protocol PrayDayDataSource
- (PrayTime*) myData:(PrayItemViewController_iPad *)sender;
@end

@interface PrayItemViewController_iPad : UIViewController
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
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *alarmButton;
- (IBAction)alarmButtonTapped:(id)sender;

@end
