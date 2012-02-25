//
//  SoundPlayer.m
//  Qonoot
//
//  Created by Sina on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SoundPlayer.h"

@interface SoundPlayer()
@property SystemSoundID sound;
@end

@implementation SoundPlayer

@synthesize sound;

-(void) playSound:(NSString*)soundName
{
    AudioServicesDisposeSystemSoundID(sound);
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"];
    CFURLRef soundURL = (__bridge CFURLRef)[NSURL fileURLWithPath:soundPath];
    AudioServicesCreateSystemSoundID(soundURL, &sound);
    AudioServicesPlaySystemSound(sound);
}

@end
