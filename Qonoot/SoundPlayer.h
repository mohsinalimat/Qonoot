//
//  SoundPlayer.h
//  Qonoot
//
//  Created by Sina on 2/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>

@interface SoundPlayer : NSObject <AVAudioPlayerDelegate>

-(void) playSound:(NSString*)soundName;

@end
