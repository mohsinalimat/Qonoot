//
//  PrayDayItemViewController.m
//  Ghonoot
//
//  Created by Sina on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayDayView.h"

@implementation PrayDayView

@synthesize dataSource = _dataSource;
@synthesize dayID;
@synthesize num;

- (void)setup
{
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    int frameSize;
    int frameHeight;
    int fontSize_day;
    int fontSize_date;
    int fontSize_round;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        frameSize = 768;
        frameHeight = 955;
        fontSize_day = 35;
        fontSize_date = 28;
        fontSize_round = 22;
    }
    else {
        frameSize = 320;
        frameHeight = 420;
        fontSize_day = 25;
        fontSize_date = 18;
        fontSize_round = 12;
    }
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"frame.png"]];
    [self addSubview:background];
    CGRect frame = CGRectMake(0, 0, frameSize, frameHeight);
    background.frame = frame;
    
    PrayTime *prayTime = [self.dataSource myData:self];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 120, frameSize, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"%@", prayTime.weekDay];
    label.font = [UIFont boldSystemFontOfSize:fontSize_day];
    [self addSubview:label];
    
    
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(0, 160, frameSize, 20)];
    date.backgroundColor = [UIColor clearColor];
    date.textColor = [UIColor whiteColor];
    date.textAlignment = UITextAlignmentCenter;
    date.text = [NSString stringWithFormat:@"%@%@%@%@%@", 
                 prayTime.month, 
                 @"/", 
                 prayTime.day, 
                 @"/", 
                 prayTime.year];
    date.font = [UIFont boldSystemFontOfSize:fontSize_date];
    [self addSubview:date];
    
    UILabel *fajr = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, frameSize, 20)];
    fajr.backgroundColor = [UIColor clearColor];
    fajr.textColor = [UIColor whiteColor];
    fajr.textAlignment = UITextAlignmentCenter;
    fajr.text = [NSString stringWithFormat:@"Fajr %@", prayTime.fajr];
    fajr.font = [UIFont boldSystemFontOfSize:12];
    [self addSubview:fajr];
    
    UILabel *sunrise = [[UILabel alloc] initWithFrame:CGRectMake(0, 215, frameSize, 20)];
    sunrise.backgroundColor = [UIColor clearColor];
    sunrise.textColor = [UIColor whiteColor];
    sunrise.textAlignment = UITextAlignmentCenter;
    sunrise.text = [NSString stringWithFormat:@"Sunrise %@", prayTime.sunrise];
    sunrise.font = [UIFont boldSystemFontOfSize:fontSize_round];
    [self addSubview:sunrise];
    
    UILabel *zuhr = [[UILabel alloc] initWithFrame:CGRectMake(0, 230, frameSize, 20)];
    zuhr.backgroundColor = [UIColor clearColor];
    zuhr.textColor = [UIColor whiteColor];
    zuhr.textAlignment = UITextAlignmentCenter;
    zuhr.text = [NSString stringWithFormat:@"zuhr %@", prayTime.zuhr];
    zuhr.font = [UIFont boldSystemFontOfSize:fontSize_round];
    [self addSubview:zuhr];
    
    UILabel *asr = [[UILabel alloc] initWithFrame:CGRectMake(0, 245, frameSize, 20)];
    asr.backgroundColor = [UIColor clearColor];
    asr.textColor = [UIColor whiteColor];
    asr.textAlignment = UITextAlignmentCenter;
    asr.text = [NSString stringWithFormat:@"Asr %@", prayTime.asr];
    asr.font = [UIFont boldSystemFontOfSize:fontSize_round];
    [self addSubview:asr];
    
    UILabel *maghrib = [[UILabel alloc] initWithFrame:CGRectMake(0, 260, frameSize, 20)];
    maghrib.backgroundColor = [UIColor clearColor];
    maghrib.textColor = [UIColor whiteColor];
    maghrib.textAlignment = UITextAlignmentCenter;
    maghrib.text = [NSString stringWithFormat:@"Maghrib %@", prayTime.maghrib];
    maghrib.font = [UIFont boldSystemFontOfSize:fontSize_round];
    [self addSubview:maghrib];
    
    UILabel *isha = [[UILabel alloc] initWithFrame:CGRectMake(0, 275, frameSize, 20)];
    isha.backgroundColor = [UIColor clearColor];
    isha.textColor = [UIColor whiteColor];
    isha.textAlignment = UITextAlignmentCenter;
    isha.text = [NSString stringWithFormat:@"Isha %@", prayTime.isha];
    isha.font = [UIFont boldSystemFontOfSize:fontSize_round];
    [self addSubview:isha];
}

#pragma mark - View lifecycle
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
