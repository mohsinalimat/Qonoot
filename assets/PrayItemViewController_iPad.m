//
//  TestViewController.m
//  Qonoot
//
//  Created by Sina on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayItemViewController_iPad.h"

@interface PrayItemViewController_iPad ()

@end

@implementation PrayItemViewController_iPad

@synthesize dayOftheWeekLabel;
@synthesize dataSource = _dataSource;
@synthesize fajrLabel;
@synthesize zuhrLabel;
@synthesize ishaLabel;
@synthesize dateLabel;
@synthesize alarmButton;
@synthesize maghribLabel;
@synthesize sunriseLabel;
@synthesize asrLabel;
@synthesize dayID;
@synthesize num;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    PrayTime *prayTime = [self.dataSource myData:self];
    if(prayTime)
    {
        dayOftheWeekLabel.text = prayTime.weekDay;
        fajrLabel.text = [NSString stringWithFormat:@"Fajr %@", prayTime.fajr];
        sunriseLabel.text = [NSString stringWithFormat:@"Sunrise %@", prayTime.sunrise];
        zuhrLabel.text = [NSString stringWithFormat:@"Zuhr %@", prayTime.zuhr];
        asrLabel.text = [NSString stringWithFormat:@"Asr %@", prayTime.asr];
        maghribLabel.text = [NSString stringWithFormat:@"Maghrib %@", prayTime.maghrib];
        ishaLabel.text = [NSString stringWithFormat:@"Isha %@", prayTime.isha];
        dateLabel.text = [NSString stringWithFormat:@"%@%@%@%@%@",
                          prayTime.month,
                          @"/",
                          prayTime.day,
                          @"/",
                          prayTime.year];
    }
}

- (void)viewDidUnload
{
    [self setDayOftheWeekLabel:nil];
    [self setFajrLabel:nil];
    [self setZuhrLabel:nil];
    [self setIshaLabel:nil];
    [self setMaghribLabel:nil];
    [self setSunriseLabel:nil];
    [self setAsrLabel:nil];
    [self setDateLabel:nil];
    [self setAlarmButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)alarmButtonTapped:(id)sender {
    NSString *round = @"fajr";
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addLocalNotification" object:round];
}
@end
