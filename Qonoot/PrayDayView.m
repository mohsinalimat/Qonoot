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

- (void)createLabel:(NSString*)type withTitle:(NSString*)title
{
    int extraPadding = 0;
    int height = 20;
    
    if([type isEqualToString:@"weekday"]){
        height = 30;
        extraPadding = 20;
    }else if([type isEqualToString:@"date"]){
        extraPadding = 30;
    }else{
        extraPadding = 60;
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (num*20)+extraPadding, 320, height)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = UITextAlignmentCenter;
    label.text = title;
    
    [self addSubview:label];
    
    if([type isEqualToString:@"weekday"])
    {
        label.font = [UIFont boldSystemFontOfSize:25];
    }else if([type isEqualToString:@"date"])
    {
        label.font = [UIFont boldSystemFontOfSize:18];
    }else{
        
    }
    
    num++;
}

- (void)drawRect:(CGRect)rect
{
    UIImageView *frame = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"frame.png"]];
    
    [self addSubview:frame];
    
    PrayTime *prayTime = [self.dataSource myData:self];
    
    [self createLabel:@"weekday" withTitle:[NSString stringWithFormat:@"%@", 
                                         prayTime.weekDay]];
    [self createLabel:@"date" withTitle:[NSString stringWithFormat:@"%@%@%@%@%@", 
                                         prayTime.month, 
                                         @"/", 
                                         prayTime.day, 
                                         @"/", 
                                         prayTime.year]];
    
    [self createLabel:@"pray" withTitle:[NSString stringWithFormat:@"Fajr %@", prayTime.fajr]];
    [self createLabel:@"pray" withTitle:[NSString stringWithFormat:@"Sunrise %@", prayTime.sunrise]];
    [self createLabel:@"pray" withTitle:[NSString stringWithFormat:@"zuhr %@", prayTime.zuhr]];
    [self createLabel:@"pray" withTitle:[NSString stringWithFormat:@"Asr %@", prayTime.asr]];
    [self createLabel:@"pray" withTitle:[NSString stringWithFormat:@"Maghrib %@", prayTime.maghrib]];
    [self createLabel:@"pray" withTitle:[NSString stringWithFormat:@"Isha %@", prayTime.isha]];
}

#pragma mark - View lifecycle
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
