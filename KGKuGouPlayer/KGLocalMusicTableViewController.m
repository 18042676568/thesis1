//
//  KGLocalMusicTableViewController.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "KGLocalMusicTableViewController.h"
#import "Music.h"
#import <AVFoundation/AVFoundation.h>
#import "KGPlayBar.h"
#import "KGMusicTableViewCell.h"
#import "CoreDataMngTool.h"
#import "AudioPlayerTool.h"

@interface KGLocalMusicTableViewController ()
@property (strong, nonatomic) NSArray* musicList;

@property (strong, nonatomic) Music* selMusic;
@end

@implementation KGLocalMusicTableViewController


-(NSArray *)musicList{
    if (_musicList == nil) {
        _musicList = [CoreDataMngTool sharedCoredataMngTool].allMusicList;
        [CoreDataMngTool sharedCoredataMngTool].curPlayList = _musicList;
    }
    return _musicList;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playNextMusic:) name:@"playNextMusic" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)playNextMusic:(NSNotification*)nofity{
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"本地音乐";
    //self.navigationItem.title = @"本地音乐";
    
    self.tableView.contentInset = UIEdgeInsetsMake(0.f, 0.f, 66.f, 0.f);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"重新加载" style:UIBarButtonItemStylePlain target:self action:@selector(searchAll:)];
    
}

#pragma mark 搜索全部歌曲
-(void)searchAll:(UIBarButtonItem*)item{
    [CoreDataMngTool loadAllMusicList];
    _musicList = nil;
    [self.tableView reloadData];
    [[AudioPlayerTool sharedAudioPlayerTool]resetPlayer];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    Music* music = self.musicList[indexPath.row];
    
    if ([music.name isEqualToString:[CoreDataMngTool sharedCoredataMngTool].curMusic.name]) {
        [[AudioPlayerTool sharedAudioPlayerTool]resetPlayer];
    }
    
    [CoreDataMngTool deleteMusic:music];
    _musicList = nil;
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.musicList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    KGMusicTableViewCell* cell = [KGMusicTableViewCell musicTableViewCellWithTableView:tableView];
    cell.delegate = self;
    cell.music = self.musicList[indexPath.row];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)musicTableViewCell:(KGMusicTableViewCell *)cell didShowHiddenMenu:(BOOL)show{
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    Music* music  = self.musicList[indexPath.row];
    music.menuHidden = !show;
    
    [self.tableView reloadData];
}


-(void)musicTableViewCell:(KGMusicTableViewCell *)cell didButtonClicked:(NSString *)title{
    NSLog(@"title %@", title);
    Music* music = self.musicList[[self.tableView indexPathForCell:cell].row];
    _selMusic = music;
    
    NSString* actionTitle = [NSString stringWithFormat:@"添加%@到:", music.name];
    
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:actionTitle delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"我喜欢", @"收藏列表", nil];
    [actionSheet showInView:self.view];
    
    music.menuHidden = YES;
    [self.tableView reloadData];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0: //我喜欢
        {
            _selMusic.isMylove = YES;
        }
            break;
        case 1: //收藏列表
        {
            
        }
            break;
        case 2: //取消
        {
            
        }
            break;
        default:
            break;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Music* music = self.musicList[indexPath.row];
    return music.menuHidden?44.f:109.f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    Music* music = self.musicList[indexPath.row];
    [CoreDataMngTool sharedCoredataMngTool].curMusic = music;
    [[AudioPlayerTool sharedAudioPlayerTool]playMusic:music.name];
    
    [self.tableView reloadData];
    
}

@end
