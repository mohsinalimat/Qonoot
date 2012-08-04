//
//  GhonootViewController.m
//  Ghonoot
//
//  Created by Sina on 1/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapsViewController.h"
#import "LocationAnnotation.h"
#import <AVFoundation/AVFoundation.h>

@interface MapsViewController()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;
@property (strong,nonatomic) NSNumber *makkeX;
@property (strong,nonatomic) UIImageView *makkeImageView;

@end

@implementation MapsViewController
@synthesize map;
@synthesize makkeX;
@synthesize makkeImageView;
@synthesize locationManager;
@synthesize compassImage;
@synthesize ghebleImage;
@synthesize segmentBar;
@synthesize mapView;
@synthesize cameraView;
@synthesize compassView;
@synthesize difference;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}
#pragma mark - View lifecycle

- (void)switchViewTo:(int)index
{
    if(index == 0)
    {
        compassView.hidden = NO;
        mapView.hidden = YES;
        cameraView.hidden = YES;
    }else if(index == 1)
    {
        compassView.hidden = YES;
        mapView.hidden = NO;
        cameraView.hidden = YES;
        [self.map selectAnnotation:[self.map.annotations objectAtIndex:0] animated:YES];
    }else if(index == 2)
    {
        compassView.hidden = YES;
        mapView.hidden = YES;
        cameraView.hidden = NO;
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        imagePicker.delegate = self;
        imagePicker.showsCameraControls = NO;
        [self presentModalViewController:imagePicker animated:YES];
        
        int frameWidth;
        
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            frameWidth = 768;
        }else{
            frameWidth = 320;
        }
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frameWidth, 480)];
        [view setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]];
        
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [doneButton setTitle:@"Done" forState:UIControlStateNormal];
        [doneButton setFrame:CGRectMake((frameWidth/2) - 60, 440, 120, 30)];
        [doneButton addTarget:self action:@selector(onDone:) forControlEvents:UIControlEventTouchDown];
        [view addSubview:doneButton];
        makkeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"makke-icon.png"]];
        [view addSubview:makkeImageView];
        
        imagePicker.cameraOverlayView = view;
    }
}

- (void)onDone:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    
    [self switchViewTo:0];
    
    [self.segmentBar setSelectedSegmentIndex:0];
}

- (void)action:(id)sender
{
    [self switchViewTo:self.segmentBar.selectedSegmentIndex];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.segmentBar addTarget:self
                        action:@selector(action:)
              forControlEvents:UIControlEventValueChanged];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    self.locationManager.headingOrientation = CLDeviceOrientationFaceUp;
    
    mapView.hidden = YES;
    LocationAnnotation *makke = [[LocationAnnotation alloc] init];
    
    self.map.delegate = self;
    [self.map setZoomEnabled:YES];
    [self.map setScrollEnabled:YES];
    self.map.mapType = MKMapTypeSatellite;
    self.map.showsUserLocation = YES;
    [self.map addAnnotation:makke];
    
#define MAP_PADDING 1.2
#define MINIMUM_VISIBLE_LATITUDE 0.001
    
    //New York
    //latitude = 40.647304 
    //longitude:-73.959961
    
    //Brisbane
    //lati = -27.3627565
    //Long = 152.7606609
    
    //Tehran
    //lati = 35
    //Long = 51
    
    //Makke
    //latitude = 21.4166667;
    //longitude = 039.8000000;
    
    float currentLatitude = 40;
    float currentLongitude = -73;
    
    float minLatitude = MIN(makke.coordinate.latitude, currentLatitude);
    float maxLatitude = MAX(makke.coordinate.latitude, currentLatitude);
    
    float minLongitude = MIN(makke.coordinate.longitude, currentLongitude);
    float maxLongitude = MAX(makke.coordinate.longitude, currentLongitude);
    
    MKCoordinateRegion region;
    region.center.latitude = (minLatitude + maxLatitude) / 2;
    region.center.longitude = (minLongitude + maxLongitude) / 2;
    
    region.span.latitudeDelta = (maxLatitude - minLatitude) * MAP_PADDING;
    
    region.span.latitudeDelta = (region.span.latitudeDelta < MINIMUM_VISIBLE_LATITUDE)
    ? MINIMUM_VISIBLE_LATITUDE 
    : region.span.latitudeDelta;
    
    region.span.longitudeDelta = (maxLongitude - minLongitude) * MAP_PADDING;
    
    MKCoordinateRegion scaledRegion = [self.map regionThatFits:region];
    [self.map setRegion:scaledRegion animated:YES];  
}

#define degreesToRadians( degrees ) ( ( degrees ) / 180.0 * M_PI )
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.2];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationRepeatCount:0];
    
    float compassBearing = 360 - [newHeading trueHeading];
    float myRadians = degreesToRadians( compassBearing );
    
    compassImage.transform = CGAffineTransformMakeRotation(myRadians);
    mapView.transform = CGAffineTransformMakeRotation(myRadians);
    
    compassBearing = compassBearing + difference;
    myRadians = degreesToRadians( compassBearing );
    
    ghebleImage.transform = CGAffineTransformMakeRotation(myRadians);
    
    int truHeading = [newHeading trueHeading];
    int adjustedHeading = truHeading - difference;
    if(adjustedHeading < 0)
    {
        adjustedHeading = adjustedHeading + 360;
    }
    
    int myNum = adjustedHeading + 180;
    if(myNum > 360)
        myNum = myNum - 360;
    myNum = myNum - 180;
    
    makkeX = [NSNumber numberWithInt:myNum];
    
    int frameWidth;
    int finalXPosition;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        frameWidth = (768/2) - 30;
        finalXPosition = ([makkeX intValue]*-1*5) + frameWidth;
        if(finalXPosition > 738)
            finalXPosition = 738;
        
        if(finalXPosition < -30)
            finalXPosition = -30;
    }else{
        frameWidth = (320/2) - 30;
        finalXPosition = ([makkeX intValue]*-1*5) + frameWidth;
        if(finalXPosition > 290)
            finalXPosition = 290;
        
        if(finalXPosition < -30)
            finalXPosition = -30;
    }
    
    [makkeImageView setFrame:CGRectMake(finalXPosition, 120, 60, 60)];
    
    [UIView commitAnimations];
}

- (BOOL)locationManagerShouldDisplayHeadingCalibration:(CLLocationManager *)manager {
    return YES;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    /*
     CLLocation *myLocation = self.locationManager.location;
     CLLocation *makke = [[CLLocation alloc] initWithLatitude:21.4166667 longitude:039.8000000];
     CLLocation *southAmerica = [[CLLocation alloc] initWithLatitude:-34.307144 longitude:22.5];
     CLLocation *brazil = [[CLLocation alloc] initWithLatitude:24.766785 longitude:-107.402344];
     CLLocation *losAngeles = [[CLLocation alloc] initWithLatitude:34.089061 longitude:-118.322754];
     CLLocation *seattle = [[CLLocation alloc] initWithLatitude:47.606163 longitude:-122.299805];
     CLLocation *newYork = [[CLLocation alloc] initWithLatitude:40.647304 longitude:-73.959961];
     
     NSLog(@"Makke      : %f", ([myLocation directionToLocation:makke] - 360));
     NSLog(@"SothAmerica: %f", ([myLocation directionToLocation:southAmerica] - 360));
     NSLog(@"Brazi      : %f", ([myLocation directionToLocation:brazil] - 360));
     NSLog(@"LA         : %f", ([myLocation directionToLocation:losAngeles] - 360));
     NSLog(@"Seattle    : %f", ([myLocation directionToLocation:seattle] - 360));
     NSLog(@"New York   : %f", ([myLocation directionToLocation:newYork] - 360));
     */
    
    CLLocation *myLocation = self.locationManager.location;
    CLLocation *makke = [[CLLocation alloc] initWithLatitude:21.4166667 longitude:039.8000000];
    difference = ([myLocation directionToLocation:makke] - 360);
}

- (void)viewDidUnload
{
    [self setCompassImage:nil];
    [self setGhebleImage:nil];
    [self setSegmentBar:nil];
    [self setCompassView:nil];
    [self setMapView:nil];
    [self setMap:nil];
    [self setCameraView:nil];
    [super viewDidUnload];
}

-(void)viewDidDisappear:(BOOL)animated
{
    //[self.locationManager stopUpdatingLocation];
    //[self.locationManager stopUpdatingHeading];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.locationManager startUpdatingLocation];
    [self.locationManager startUpdatingHeading];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return NO;
    }
}

@end
