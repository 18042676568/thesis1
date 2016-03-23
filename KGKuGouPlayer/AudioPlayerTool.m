//
//  AudioPlayerTool.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/23.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "AudioPlayerTool.h"
#import "KGPlayBar.h"
#import "CoreDataMngTool.h"

static AudioPlayerTool* tool;

@implementation AudioPlayerTool

+(instancetype)sharedAudioPlayerTool{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        tool = [[AudioPlayerTool alloc]init];
    });
    return tool;
}


-(void)playMusic:(NSString *)musicName{
    
    NSString* fullMusicName = [NSString stringWithFormat:@"%@.mp3", musicName];
    
    NSURL* musicURL = [[NSBundle mainBundle]URLForResource:fullMusicName withExtension:nil];
    
    _audioPlayer = nil;
    AVAudioPlayer* audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:musicURL error:nil];
    _audioPlayer = audioPlayer;
    audioPlayer.delegate = self;
    [audioPlayer prepareToPlay];
    [audioPlayer play];
    
    //遍历window的所有子控件，如果子控件的类型是KGPlayBar就设置它的模型。
    for (UIView* subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([subView isKindOfClass:[KGPlayBar class]]) {
            KGPlayBar* playBar = (KGPlayBar*)subView;
            playBar.playButton.selected = YES;
            playBar.progress.progress = 0.0;
            _nowPlayTime = 0.0f;
            if (_oldTimer != nil) {
                [_oldTimer invalidate];
                _oldTimer = nil;
            }
            NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateProgress:) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
            
            _oldTimer = timer;
            
            playBar.delegate = self;
            playBar.music = [CoreDataMngTool sharedCoredataMngTool].curMusic;
        }
    }
}

-(void)playBar:(KGPlayBar *)playBar didPlayPauseMusic:(BOOL)playMethod{
    if (playMethod) {
        [[AudioPlayerTool sharedAudioPlayerTool].audioPlayer play];
    }else{
        [[AudioPlayerTool sharedAudioPlayerTool].audioPlayer pause];
    }
}

-(void)playBarDidPlayNextMusic:(KGPlayBar *)playBar{
    [CoreDataMngTool sharedCoredataMngTool].curMusic = [CoreDataMngTool sharedCoredataMngTool].nextMusic;
    [[AudioPlayerTool sharedAudioPlayerTool]playMusic:[CoreDataMngTool sharedCoredataMngTool].curMusic.name];
    
    //发一个播放下一曲的通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"playNextMusic" object:nil];
}

-(void)resetPlayer{
    [[AudioPlayerTool sharedAudioPlayerTool].audioPlayer stop];
    [AudioPlayerTool sharedAudioPlayerTool].audioPlayer = nil;
    
    for (UIView* subView in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([subView isKindOfClass:[KGPlayBar class]]) {
            KGPlayBar* playBar = (KGPlayBar*)subView;
            playBar.musicName.text = @"酷狗音乐";
            playBar.singer.text = @"传播好音乐";
            playBar.progress.progress = 0.f;
        }
    }
    [CoreDataMngTool sharedCoredataMngTool].curMusic = nil;
}

-(void)updateProgress:(NSTimer*) timer{
    if ([[AudioPlayerTool sharedAudioPlayerTool].audioPlayer isPlaying]) {
        _nowPlayTime = _nowPlayTime+1.0f;
        Music* music = [CoreDataMngTool sharedCoredataMngTool].curMusic;
        CGFloat totaltime = [music.time floatValue];

        CGFloat nowtimeProgressValue = _nowPlayTime/totaltime;

        if (nowtimeProgressValue >= 1.0f) {
            nowtimeProgressValue = 1.0f;
        }

        for (UIView* view in [UIApplication sharedApplication].keyWindow.subviews) {
            if ([view isKindOfClass:[KGPlayBar class]]) {
                KGPlayBar* playBar = (KGPlayBar*)view;
                playBar.progress.progress = nowtimeProgressValue;
            }
        }
    }

}

-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self playBarDidPlayNextMusic:nil];
}

-(void)pauseMusic{
    if (_audioPlayer != nil) {
        [_audioPlayer pause];
    }
}

@end
