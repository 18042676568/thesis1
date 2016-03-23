//
//  KGHomePageViewController.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/15.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "KGHomePageViewController.h"
#import "KGHomePageMusicTableViewCell.h"
#import "KGPlayBar.h"
#import "AppDelegate.h"
#import "CoreDataMngTool.h"

//用enum区分三个不同的选项 自定义enum类型
typedef enum{
    eMyMusic = 0,
    eNetMusic,
    eMoreFounction
}eMusicSel;

@interface KGHomePageViewController ()
@property (weak, nonatomic) IBOutlet UIView *verticalLine;
@property (weak, nonatomic) IBOutlet UIButton *icon;
- (IBAction)logon:(UIButton *)sender;
- (IBAction)signin:(UIButton *)sender;
- (IBAction)switchbtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)myMusic:(UIButton *)sender;
- (IBAction)netMusic:(UIButton *)sender;
- (IBAction)moreFunction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *arrow;
@property (weak, nonatomic) IBOutlet UIButton *netMusicButton;
@property (weak, nonatomic) IBOutlet UIButton *moreFunctionButton;
@property (weak, nonatomic) IBOutlet UIButton *myMusicButton;


@property (assign, nonatomic) NSInteger curselectedRow;
@property (strong, nonatomic) NSMutableArray* cellStatus;
@property (strong, nonatomic) NSArray* cellContents;
//用enum区分三个不同的选项
@property (assign, nonatomic) eMusicSel musicSel;

@end

@implementation KGHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _tableView.dataSource = self;
//    _tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    //设置tabelFooterView为空，则没有文字的cell下边就不会出现分割线
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

     _curselectedRow = -1;
    
    KGPlayBar* playBar = [KGPlayBar playBar];
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    [delegate.window addSubview:playBar];


}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
    NSLog(@"本地音乐 %@", [CoreDataMngTool sharedCoredataMngTool].curMusic.name);
    NSLog(@"本地音乐 oldMusic %@", [CoreDataMngTool sharedCoredataMngTool].oldMusic.name);
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //默认选中的是我的音乐
    [self myMusic:_myMusicButton];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(NSMutableArray *)cellStatus{
    if (_cellStatus == nil) {
        _cellStatus = [NSMutableArray array];
        NSString* fileName = @"MyMusicSelList.plist";
        switch (_musicSel) {
            case eMyMusic:
            {
                fileName = @"MyMusicSelList.plist";
            }
                break;
            case eNetMusic:
            {
                fileName = @"webMusicList.plist";
            }
                break;
            case eMoreFounction:
            {
                fileName = @"MoreList.plist";
            }
                break;
            default:
                break;
        }
        _cellContents = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:nil]];
        
        for (int i=0; i<_cellContents.count; i++) {
            NSDictionary* dict = @{@"selected": @0};
            KGMusicCellStatus* status = [KGMusicCellStatus musicCellStatusWithDict:dict];
            [_cellStatus addObject:status];
        }
    }
    return _cellStatus;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cellStatus.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    KGHomePageMusicTableViewCell* cell = [KGHomePageMusicTableViewCell homePageMusicTableViewCellWithTableView:tableView];
    cell.status = self.cellStatus[indexPath.row];
    if (_cellContents != nil) {
        cell.textLabel.text = _cellContents[indexPath.row];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_curselectedRow >= 0) {
        KGMusicCellStatus* oldstatus = self.cellStatus[_curselectedRow];
        oldstatus.selected = NO;
    }
    KGMusicCellStatus* status = self.cellStatus[indexPath.row];
    status.selected = YES;
    
    _curselectedRow = indexPath.row;
    
    [self.tableView reloadData];
    
    
    switch (_musicSel) {
            //我的音乐
        case eMyMusic:
        {
            //本地音乐
            if (indexPath.row == 0) {
                [self performSegueWithIdentifier:@"toLocalMusic" sender:nil];
            }
            //我喜欢
            if (indexPath.row == 1) {
                [self performSegueWithIdentifier:@"toMyLove" sender:nil];
            }
            //收藏列表
            if (indexPath.row == 2) {
                [self performSegueWithIdentifier:@"toSaveList" sender:nil];
            }
        }
            break;
        case eNetMusic:
        {
            
        }
            break;
        case eMoreFounction:
        {
            
        }
            break;
        default:
            break;
    }
    
    
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 登录
- (IBAction)logon:(UIButton *)sender {
    
}
#pragma mark 注册
- (IBAction)signin:(UIButton *)sender {
    
}

#pragma mark 按钮切换
- (IBAction)switchbtn:(UIButton *)sender {
    sender.selected = !sender.selected;
}

#pragma mark 我的音乐
- (IBAction)myMusic:(UIButton *)sender {
    sender.selected = YES;
    _netMusicButton.selected = NO;
    _moreFunctionButton.selected = NO;
    
    _musicSel = eMyMusic;
    _cellStatus = nil;
    _curselectedRow = -1;
    [self.tableView reloadData];
    
    _arrow.center = CGPointMake(_verticalLine.center.x-2, sender.center.y);
    
}

#pragma mark 网络音乐
- (IBAction)netMusic:(UIButton *)sender {
    sender.selected = YES;
    _myMusicButton.selected = NO;
    _moreFunctionButton.selected = NO;

    _musicSel = eNetMusic;
    _cellStatus = nil;
    _curselectedRow = -1;
    [self.tableView reloadData];
    
     _arrow.center = CGPointMake(_verticalLine.center.x-2, sender.center.y);
}

#pragma mark 更多功能
- (IBAction)moreFunction:(UIButton *)sender {
    sender.selected = YES;
    _netMusicButton.selected = NO;
    _myMusicButton.selected = NO;

    _musicSel = eMoreFounction;
    _cellStatus = nil;
    _curselectedRow = -1;
    [self.tableView reloadData];
    
     _arrow.center = CGPointMake(_verticalLine.center.x-2, sender.center.y);
}
@end
