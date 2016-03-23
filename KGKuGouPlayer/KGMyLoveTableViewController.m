//
//  KGMyLoveTableViewController.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "KGMyLoveTableViewController.h"
#import "CoreDataMngTool.h"
#import "KGMusicTableViewCell.h"
#import "AudioPlayerTool.h"

@interface KGMyLoveTableViewController ()
@property (strong, nonatomic) NSArray* myLoveList;
@end

@implementation KGMyLoveTableViewController


-(NSArray *)myLoveList{
    if (_myLoveList == nil) {
        _myLoveList = [CoreDataMngTool serachMyLoveMusics];
        [CoreDataMngTool sharedCoredataMngTool].curPlayList = _myLoveList;
    }
    return _myLoveList;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    Music* music = self.myLoveList[indexPath.row];
    
    if ([music.name isEqualToString:[CoreDataMngTool sharedCoredataMngTool].curMusic.name]) {
        [[AudioPlayerTool sharedAudioPlayerTool]resetPlayer];
    }
    
//    [CoreDataMngTool deleteMusic:music];
    music.isMylove = NO;
    _myLoveList = nil;
    
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
    return self.myLoveList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    KGMusicTableViewCell* cell = [KGMusicTableViewCell musicTableViewCellWithTableView:tableView];
    //cell.delegate = self;
    cell.music = self.myLoveList[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;

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
    
    self.title = @"我喜欢";
    //self.navigationItem.title = @"本地音乐";
    
    self.tableView.contentInset = UIEdgeInsetsMake(0.f, 0.f, 66.f, 0.f);
    
}

-(void)musicTableViewCell:(KGMusicTableViewCell *)cell didShowHiddenMenu:(BOOL)show{
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    Music* music  = self.myLoveList[indexPath.row];
    music.menuHidden = !show;
    
    [self.tableView reloadData];
}

-(void)musicTableViewCell:(KGMusicTableViewCell *)cell didButtonClicked:(NSString *)title{
    NSLog(@"title %@", title);
    Music* music = self.myLoveList[[self.tableView indexPathForCell:cell].row];
    
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
    Music* music = self.myLoveList[indexPath.row];
    return music.menuHidden?44.f:109.f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Music* music = self.myLoveList[indexPath.row];
    [CoreDataMngTool sharedCoredataMngTool].curMusic = music;
    [[AudioPlayerTool sharedAudioPlayerTool]playMusic:music.name];
    
    [self.tableView reloadData];
    
}

@end
