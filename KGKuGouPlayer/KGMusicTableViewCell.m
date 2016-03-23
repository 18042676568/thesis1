//
//  KGMusicTableViewCell.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "KGMusicTableViewCell.h"
#import "UIView+Extension.h"
#import "KGMusicMenu.h"

#define Margin 13.f

@implementation KGMusicTableViewCell

+(instancetype)musicTableViewCellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"musicTableViewCell";
    
    KGMusicTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[KGMusicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    return cell;
}

//纯代码自定义TableViewCell 添加子控件在initWithStyle初始化方法中
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.f);
        
        //添加按钮
        UIButton* addButton = [[UIButton alloc]init];
        _addButton = addButton;
        addButton.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:addButton];
        [addButton addTarget:self action:@selector(addMuiscToPlayList:) forControlEvents:UIControlEventTouchUpInside];
        
        //歌曲名
        UILabel* musicName = [[UILabel alloc]init];
        _musicName = musicName;
        [self.contentView addSubview:musicName];
        
        //MV按钮
        UIButton* mvButton= [[UIButton alloc]init];
        _mvButton = mvButton;
        mvButton.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:mvButton];
        [mvButton addTarget:self action:@selector(mvPlay:) forControlEvents:UIControlEventTouchUpInside];
        
        //更多菜单按钮
        UIButton* moreButton = [[UIButton alloc]init];
        _moreButton = moreButton;
        moreButton.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:moreButton];
        [moreButton addTarget:self action:@selector(moreMenu:) forControlEvents:UIControlEventTouchUpInside];
        
        //更多菜单
//        NSArray* infos = @[@{@"title": @"下载"},
//                           @{@"title": @"添加"},
//                           @{@"title": @"分享"},
//                           @{@"title": @"歌曲信息"},
//                           @{@"title": @"K歌"}];
//        
        NSArray* infos = @[@{@"title": @"下载",
                             @"image": @"download"},
                           @{@"title": @"我喜欢",
                             @"image": @"addPlayList"},
                           @{@"title": @"收藏",
                             @"image": @"share"}];
        
        
        KGMusicMenu* menu = [KGMusicMenu musicMenuWithInfos:infos];
        menu.delegate = self;
        _background = menu;
        menu.hidden = YES;
        [self.contentView addSubview:menu];
    }
    
    return self;
}

-(void)musicMenu:(KGMusicMenu *)musicMenu didButtonClicked:(NSString *)title{
    if ([_delegate respondsToSelector:@selector(musicTableViewCell:didButtonClicked:)]) {
        [_delegate musicTableViewCell:self didButtonClicked:title];
    }
}

//定义子控件的大小位置
-(void)layoutSubviews{
    [super layoutSubviews];
    
    _addButton.frame = CGRectMake(Margin, Margin, 18.f, 18.f);
    
    _moreButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-Margin-29.f, (44.f-20.f)*0.5, 29.f, 20.f);
    
    _mvButton.frame = CGRectMake(_moreButton.left-Margin-29.f, (44.f-20.f)*0.5, 29.f, 20.f);
    
    _musicName.frame = CGRectMake(_addButton.right+Margin, _addButton.top, _mvButton.left-_addButton.right-Margin, 18.f);
    
    _background.frame = CGRectMake(0, 44.f, [UIScreen mainScreen].bounds.size.width, 65.f);
    
//    CGFloat buttonW = [UIScreen mainScreen].bounds.size.width/_background.subviews.count;
//    CGFloat buttonY = 0.f;
//    CGFloat buttonH = _background.height;
//    
//    NSUInteger index = 0;
//    for (UIButton* button in _background.subviews) {
//        CGFloat buttonX = index*buttonW;
//        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//        index++;
//    }
    
}

#pragma mark 添加歌曲到播放列表
-(void)addMuiscToPlayList:(UIButton*)sender{
    
}

#pragma mark 播放MV
-(void)mvPlay:(UIButton*)sender{
    
}

#pragma mark 弹出更多的菜单
-(void)moreMenu:(UIButton*)sender{
    sender.selected = !sender.selected;
    if ([_delegate respondsToSelector:@selector(musicTableViewCell:didShowHiddenMenu:)]) {
        [_delegate musicTableViewCell:self didShowHiddenMenu:sender.selected];
    }
}

-(void)setMusic:(Music *)music{
    _music = music;
    [_musicName setText:music.name];
    if (music.menuHidden) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.f);
    }else{
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44.f+65.f);
    }
    
    if (music.isPlay) {
        _musicName.textColor = [UIColor redColor];
    }else{
        _musicName.textColor = [UIColor blackColor];
    }
    
    _background.hidden = music.menuHidden;
}

@end
