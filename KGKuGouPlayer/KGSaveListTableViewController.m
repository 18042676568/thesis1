//
//  KGSaveListTableViewController.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "KGSaveListTableViewController.h"
#import "KGSaveListView.h"
#import "UIView+Extension.h"
#import "SaveList.h"
#import "CoreDataMngTool.h"


@interface KGSaveListTableViewController ()
@property (weak, nonatomic) KGSaveListView* saveListView;
@property (strong ,nonatomic) NSArray* saveListArray;
@end

@implementation KGSaveListTableViewController

-(NSArray *)saveListArray{
    if (_saveListArray == nil) {
        _saveListArray = [CoreDataMngTool sharedCoredataMngTool].saveNameList;
    }
    return _saveListArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加列表" style:UIBarButtonItemStylePlain target:self action:@selector(addSaveListTitle:)];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoradChange:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoradChange:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)keyBoradChange:(NSNotification*)notify{
    if ([notify.name isEqualToString:@"UIKeyboardWillShowNotification"]) {
        NSDictionary * userInfo = notify.userInfo;
        NSString * duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        CGRect endRect = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
        
        if (_saveListView.bottom < endRect.origin.y) {
            return;
            
        }
        CGPoint saveListCenter = CGPointMake(_saveListView.center.x, endRect.origin.y-54.f);
        [UIView animateWithDuration:[duration floatValue] animations:^{
            _saveListView.center = saveListCenter;
            
        }];
    }else if([notify.name isEqualToString:@"UIKeyboardWillHideNotification"]) {
        NSDictionary * userInfo = notify.userInfo;
        NSString * duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        
        
        [UIView animateWithDuration:[duration floatValue] animations:^{
            _saveListView.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*0.5);
        }];
        
    }
}

#pragma mark 添加收藏列表标题（添加收藏的文件夹）
-(void)addSaveListTitle:(id)sender{
    NSLog(@"添加收藏！");

    KGSaveListView* saveListView = [KGSaveListView saveListView];
    //为了自定义View 不跟随TableView联动 可以将自定义View添加到window，如果控制器是
    //在导航控制器控制器下的，可以添加到导航控制器的View 上去。
    [saveListView showinView:self.view.window];
    _saveListView = saveListView;
    saveListView.delegate = self;
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backGroundClicked:)];
    [saveListView.mengBoard addGestureRecognizer:tap];
    
}

-(void)backGroundClicked:(id)sender{
    [_saveListView endEditing:YES];
}

-(void)saveListView:(KGSaveListView *)saveListView didSaveListNameConfirm:(NSString *)saveListName{
    [saveListView hide];
    NSLog(@"%@",saveListName);
    
    BOOL ret = [[CoreDataMngTool sharedCoredataMngTool]addSaveList:saveListName];
    
    if (ret == NO) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"收藏列表已存在" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show];
    }
    
//    NSDictionary* dict = @{@"name":saveListName};
//    //播放模型的创建，同时已经存储到coredata数据库中了
//    [SaveList saveListWithDict:dict];
//    [CoreDataMngTool sharedCoredataMngTool].saveNameList = nil;
    
    _saveListArray = nil;
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.saveListArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 0;
}

//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    SaveList* saveList = self.saveListArray[section];
//    return saveList.name;
//}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    KGSaveListSectionHeaderView* heaerView = [KGSaveListSectionHeaderView saveListSectionHeaderView];
    heaerView.delegate = self;
    heaerView.saveList = self.saveListArray[section];
    heaerView.tag = section;
    return heaerView;
}

-(void)saveListSectionHeaderViewdidDeleteButtonClicked:(KGSaveListSectionHeaderView *)headerView{
    SaveList* savelList = self.saveListArray[headerView.tag];
    [CoreDataMngTool deleteSaveList:savelList];
    _saveListArray = nil;
    [self.tableView reloadData];
    
//    [self.tableView reloadRowsAtIndexPaths:<#(NSArray *)#> withRowAnimation:<#(UITableViewRowAnimation)#>]
//    NSIndexSet* set =
//    [self.tableView reloadSections:(NSIndexSet *) withRowAnimation:<#(UITableViewRowAnimation)#>]
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.f;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

@end
