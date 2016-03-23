//
//  AudioPlayerTool.h
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/23.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "KGPlayBar.h"

@interface AudioPlayerTool : NSObject<AVAudioPlayerDelegate,KGPlayBarDelegate>
@property (strong, nonatomic) AVAudioPlayer* audioPlayer;
@property (assign, nonatomic) CGFloat nowPlayTime;
@property (strong, nonatomic) NSTimer* oldTimer;

+(instancetype)sharedAudioPlayerTool;

-(void)playMusic:(NSString*)musicName;
-(void)pauseMusic;

-(void)resetPlayer;

@end
