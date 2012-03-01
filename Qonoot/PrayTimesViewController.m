//
//  PrayDayViewController.m
//  Ghonoot
//
//  Created by Sina on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PrayTimesViewController.h"
#import "LocalNotificationsManager.h"

@interface PrayTimesViewController() <PrayDayDataSource>
@property (nonatomic, strong) LocalNotificationsManager *lnm;
@end

@implementation PrayTimesViewController

@synthesize prayerTimes = _prayerTimes;
@synthesize spinner;
@synthesize scrollView;
@synthesize locationManager;
@synthesize longtitude;
@synthesize latitude;
@synthesize timeZone;
@synthesize lnm = _lnm;
@synthesize num;

- (LocalNotificationsManager *)lnm
{
    if (!_lnm) _lnm = [LocalNotificationsManager sharedManager];
    return _lnm;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)callWebService
{
    [spinner startAnimating];
    //http://www.islamicfinder.org/prayer_service.php?country=united_kingdom&city=london&state=0&zipcode=&latitude=40.7500&longitude=-73.9967&timezone=-5.0&HanfiShafi=1&pmethod=5&fajrTwilight1=&fajrTwilight2=&ishaTwilight=0&ishaInterval=0&dhuhrInterval=1&maghribInterval=1&dayLight=1&simpleFormat=xml
    
    //http://www.islamicfinder.org/prayer_service.php?country=united_kingdom&city=london&state=0&zipcode=&latitude=40.75&longtitude=-73.9967&timezone=-5&HanfiShafi=1&pmethod=5&fajrTwilight1=&fajrTwilight2=&ishaTwilight=0&ishaInterval=0&dhuhrInterval=1&maghribInterval=1&dayLight=1&simpleFormat=xml
    
    NSString *base = @"http://www.islamicfinder.org/prayer_service.php?country=united_kingdom&city=london&state=0&zipcode=";
    
    NSString *end = @"&HanfiShafi=1&pmethod=5&fajrTwilight1=&fajrTwilight2=&ishaTwilight=0&ishaInterval=0&dhuhrInterval=1&maghribInterval=1&dayLight=1&simpleFormat=xml&monthly=1&month=";
    
    NSString *latitudeURL = @"&latitude=";
    NSString *latitudeValue = latitude;
    NSString *longitudeURL = @"&longitude=";
    NSString *longitudeValue = longtitude;
    NSString *timeZoneURL = @"&timezone=";
    NSString *timeZoneValue = timeZone;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger month = [components month];
    NSString *monthValue = [NSString stringWithFormat:@"%i", month];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@", 
                           base, 
                           latitudeURL, 
                           latitudeValue, 
                           longitudeURL, 
                           longitudeValue, 
                           timeZoneURL, 
                           timeZoneValue, 
                           end,
                           monthValue];
    
    NSURL *url = [NSURL URLWithString:urlString];
    //NSLog(@"show:%@", url);
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request setDidFinishSelector:@selector(requestCompleted:)];
    [request setDidFailSelector:@selector(requestError:)];
    
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void) createButton
{
    if ([num intValue] < [_prayerTimes count])
    {
        PrayDayView *item = [[PrayDayView alloc] initWithFrame:CGRectMake(scrollView.contentSize.width, 0, 320, 20)];
        item.dayID = num;
        item.backgroundColor = [UIColor clearColor];
        [item setNeedsDisplay];
        item.dataSource = self;
        [scrollView addSubview:item];
        [scrollView setContentSize:CGSizeMake(item.frame.origin.x + item.frame.size.width, 100)];
        
        int value = [num intValue];
        num = [NSNumber numberWithInt:value + 1];
    }
}

- (void)requestCompleted:(ASIHTTPRequest *)request
{
    [spinner stopAnimating];
    
    NSString *responseString = [request responseString];
    //NSLog(@"Response: %@", responseString);
    
    NSString *nan = [responseString stringByRemovingNewLinesAndWhitespace];
    
    NSString *res = [[NSString alloc] initWithString:[nan substringFromIndex:3]];
    
    NSDictionary *xmlDictionary = [XMLReader dictionaryForXMLString:res error:nil];
    NSDictionary *response = [xmlDictionary valueForKey:@"prayer"];
    //NSLog(@"Res: %@", response);
    
    NSArray *dates = [response valueForKey:@"date"];
    
    _prayerTimes = [[NSMutableArray alloc] init];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger day = [components day]-1;
    
    for (int i = day; i < [dates count]; i++) {
        NSDictionary *date = [dates objectAtIndex:i];
        
        NSString *weekDay       = [date valueForKey:@"week_day"];
        NSString *day           = [date valueForKey:@"day"];
        NSString *month         = [date valueForKey:@"month"];
        NSString *year          = [date valueForKey:@"year"];
        NSDictionary *asr       = [date valueForKey:@"asr"];
        NSDictionary *fajr      = [date valueForKey:@"fajr"];
        NSDictionary *isha      = [date valueForKey:@"isha"];
        NSDictionary *maghrib   = [date valueForKey:@"maghrib"];
        NSDictionary *sunrise   = [date valueForKey:@"sunrise"];
        NSDictionary *zuhr      = [date valueForKey:@"dhuhr"];
        
        PrayTime *time = [[PrayTime alloc] init];
        [time setDayIndex:[NSString stringWithFormat:@"%i",(i+1)]];
        [time setWeekDay:weekDay];
        [time setDay:day];
        [time setMonth:month];
        [time setYear:year];
        [time setAsr:[asr valueForKey:@"text"]];
        [time setFajr:[fajr valueForKey:@"text"]];
        [time setIsha:[isha valueForKey:@"text"]];
        [time setMaghrib:[maghrib valueForKey:@"text"]];
        [time setSunrise:[sunrise valueForKey:@"text"]];
        [time setZuhr:[zuhr valueForKey:@"text"]];
        
        [_prayerTimes addObject:time];
    }
    
    [self createButton];
    [self createButton];
}

- (void)requestError:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Error loading XML: %@", error);
}


-(void)addLocalNotification:(NSNotification *) notification
{
    NSString *round = notification.object;
    
    if([round isEqualToString:@"all"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addLocalNotification" object:@"asr"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addLocalNotification" object:@"fajr"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addLocalNotification" object:@"sunrise"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addLocalNotification" object:@"zuhr"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addLocalNotification" object:@"maghrib"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addLocalNotification" object:@"isha"];
    }else
    {
        for (int i = 0; i < [_prayerTimes count]; i++) 
        {
            PrayTime *pt = [_prayerTimes objectAtIndex:i];
            [self.lnm addLocalNotification:round withPrayTime:pt];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{    
    CLLocation *location = self.locationManager.location;
    longtitude = [[NSString alloc] initWithFormat:@"%g", location.coordinate.longitude];
    latitude = [[NSString alloc] initWithFormat:@"%g", location.coordinate.latitude];
    NSTimeZone *currentDateTimeZone = [NSTimeZone localTimeZone];
    timeZone = [[NSString alloc] initWithFormat:@"%i", currentDateTimeZone.secondsFromGMT/3600];
    
    [locationManager stopUpdatingLocation];
    
    [self callWebService];
    
    //NSLog(@"Long: %@", longtitude);
    //NSLog(@"Lati: %@", latitude);
    //NSLog(@"TZ: %@", timeZone);
}

- (PrayTime*) myData:(PrayDayView *)sender{
    return [_prayerTimes objectAtIndex:[sender.dayID intValue]];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)sv
{
    CGSize size = scrollView.contentSize;
    CGPoint position = scrollView.contentOffset;
    if(position.x == (size.width-320))
    {
        [self createButton];
    }
}

#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [spinner stopAnimating];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addLocalNotification:) name:@"addLocalNotification" object:nil];
    
    [scrollView setContentSize:CGSizeMake(0, 100)];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    
    _prayerTimes = [[NSMutableArray alloc] init];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    self.locationManager.headingOrientation = CLDeviceOrientationFaceUp;
    [self.locationManager startUpdatingLocation];    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidUnload {
    [self setScrollView:nil];
    [self setSpinner:nil];
    [super viewDidUnload];
}
@end
