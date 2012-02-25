//
//  LocationAnnotation.m
//  Ghonoot
//
//  Created by Sina on 2/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationAnnotation.h"

@implementation LocationAnnotation

- (NSString*) title
{
    return @"Qibla";
}

- (NSString*) subtitle
{
    return [NSString stringWithFormat:@"%f%@%f", self.coordinate.latitude, @", ", self.coordinate.longitude];
}

- (CLLocationCoordinate2D) coordinate  
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 21.4166667;
    coordinate.longitude = 039.8000000;
    return coordinate;
}

@end
