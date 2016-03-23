//
//  KGPlayBar.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "KGPlayBar.h"
#import "UIView+Extension.h"

@implementation KGPlayBar

+(instancetype)playBar{
    KGPlayBar* playBar = [[[NSBundle mainBundle] loadNibNamed:@"PlayBar" owner:nil options:nil]lastObject];
    playBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height-66.f, [UIScreen mainScreen].bounds.size.width, 66.f);
    playBar.progress.progress = 0.f;
    return playBar;
}


//根据屏幕的不同，重新适配子控件
-(void)layoutSubviews{
    [super layoutSubviews];
    //音乐图标
    _icon.frame = CGRectMake(10.f, 2.f, 62.f, 62.f);
    
    //进度条
    _progress.frame = CGRectMake(_icon.right+8.f, 8.f, [UIScreen mainScreen].bounds.size.width-_icon.right-8.f-8.f, 2.f);
    
    //下一曲按钮
    _nextButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-8.f-30.f, 23.f, 30.f, 30.f);
    
    //播放按钮
    _playButton.frame = CGRectMake(_nextButton.left-30.f, _nextButton.top, 30.f, 30.f);
    
    //歌曲名
    _musicName.frame  = CGRectMake(_icon.right+8.f, 18.f, _playButton.left-_icon.right-8.f, 21.f);
    
    //歌者
    _singer.frame = CGRectMake(_musicName.left, 43.f, _musicName.width, 21.f);
    
}

-(void)setMusic:(Music *)music{
    _musicName.text = music.name;
    _singer.text = music.singer;
}

#pragma mark 播放暂停歌曲
- (IBAction)playPauseMusic:(UIButton*)sender {
    sender.selected = !sender.selected;
    if ([_delegate respondsToSelector:@selector(playBar:didPlayPauseMusic:)]) {
        [_delegate playBar:self didPlayPauseMusic:sender.selected];
    }
}

#pragma mark 播放下一曲
- (IBAction)Playnext:(id)sender {
    if ([_delegate respondsToSelector:@selector(playBarDidPlayNextMusic:)]) {
        [_delegate playBarDidPlayNextMusic:self];
    }
}

@end
