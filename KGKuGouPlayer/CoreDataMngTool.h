//
//  CoreDataMngTool.h
//  iOSCoreDataDemo
//
//  Created by hegf on 15/9/10.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Music.h"
#import "SaveList.h"

@interface CoreDataMngTool : NSObject

//所有歌曲列表
@property (strong, nonatomic) NSArray* allMusicList;

//我喜欢列表
@property (strong, nonatomic) NSArray* myLoveList;

//当前播放的音乐列表
@property (strong, nonatomic) NSArray* curPlayList;
           
@property (strong, nonatomic) Music* oldMusic;
@property (strong, nonatomic) Music* curMusic;
@property (strong, nonatomic) Music* nextMusic;

//重新加载所有歌曲
+(void)loadAllMusicList;

//查询所有Music的方法
+(NSArray*)serachMusics;

//查询我喜欢Music的方法
+(NSArray *)serachMyLoveMusics;

//删除一个Music的方法
+(void)deleteMusic:(Music*)music;

//删除所有音乐
+(void)deleteAllMusic;

//查询所有以keyString开头的人
+(NSArray*)searchPersonsWithKeyString:(NSString*) keyString;


/****************************************************/
/******** 播放列表相关的函数 ***************************/
/****************************************************/

//收藏列表(保存的是收藏文件夹的名字)
@property (strong, nonatomic) NSMutableArray* saveNameList;

//查询所有收藏列表文件夹名字
+(NSArray*)searchSaveNames;
//删除一个收藏列表的方法
+(void)deleteSaveList:(SaveList*)saveList;

//添加一个收藏列表文件夹到Coredata数据库中 返回值 YES添加成功 NO失败
-(BOOL)addSaveList:(NSString*)saveListName;

//单例的实现 第一步sharedXXXTool
+(instancetype)sharedCoredataMngTool;
@end
