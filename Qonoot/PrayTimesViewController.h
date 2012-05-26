//
//  PrayDayViewController.h
//  Ghonoot
//
//  Created by Sina on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "ASIHTTPRequest.h"
#import "XMLReader.h"
#import "PrayTime.h"
#import "CLLocation+measuring.h"
#import "NSString+HTML.h"
#import "LocalNotificationsManager.h"
#import "PrayItemViewController.h"

@interface PrayTimesViewController : UIViewController <CLLocationManagerDelegate, UIScrollViewDelegate>
{
    CLLocationManager *locationManager;
    NSString *longtitude;
    NSString *latitude;
    NSString *timeZone;
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) NSNumber *num;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSString *longtitude;
@property (strong, nonatomic) NSString *latitude;
@property (strong, nonatomic) NSString *timeZone;
@property (strong, nonatomic) NSMutableArray *prayerTimes;
@property (strong, nonatomic) PrayItemViewController *prayItem;

@end
