
//
//  CoreDataMngTool.m
//  iOSCoreDataDemo
//
//  Created by hegf on 15/9/10.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "CoreDataMngTool.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

//单例第二步 定义一个static tool
static CoreDataMngTool* tool;

@implementation CoreDataMngTool

//单例第三步，实现sharedXXXTool 使用dispatch_once保证 alloc init只调用一次
+(instancetype)sharedCoredataMngTool{
    
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        tool = [[CoreDataMngTool alloc]init];
        if (tool) {
            tool.oldMusic = nil;
            tool.curMusic = nil;
        }
    });

    return tool;
}


-(NSArray *)allMusicList{
    if (_allMusicList == nil) {
        _allMusicList = [CoreDataMngTool serachMusics];
    }
    return _allMusicList;
}

-(NSArray *)myLoveList{
    if (_myLoveList == nil) {
        _myLoveList = [CoreDataMngTool serachMyLoveMusics];
    }
    return _myLoveList;
}

+(void)loadAllMusicList{
    [CoreDataMngTool deleteAllMusic];
    NSArray* dictList = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LocolMusicList.plist" ofType:nil]];
    for (int i=0; i<dictList.count; i++) {
        NSDictionary* dict = dictList[i];
        //创建歌曲模型，保存到数据库coredata中
        [Music musicWithDict:dict];
    }
    //全盘重新加载完歌曲到数据库中，原来的歌曲列表就不要了
    [CoreDataMngTool sharedCoredataMngTool].allMusicList = nil;
    [CoreDataMngTool sharedCoredataMngTool].oldMusic = nil;
    [CoreDataMngTool sharedCoredataMngTool].curMusic = nil;
    
    
}


+(NSArray *)serachMusics{
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"Music" inManagedObjectContext:delegate.managedObjectContext];
    request.entity = desc;
    
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
//    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    NSError *error = nil;
    NSArray *objs = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    return objs;

}

+(NSArray *)serachMyLoveMusics{
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"Music" inManagedObjectContext:delegate.managedObjectContext];
    request.entity = desc;
    
    //    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    //    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    //查询条件的设置
    NSPredicate * qcondition= [NSPredicate predicateWithFormat:@"isMylove = 1"];
    request.predicate = qcondition;
    
    NSError *error = nil;
    NSArray *objs = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    return objs;
    
}

+(void)deleteAllMusic{
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    NSArray* musics = [CoreDataMngTool serachMusics];
    for (int i=0; i<musics.count; i++) {
        [CoreDataMngTool deleteMusic:musics[i]];
    }
    NSError *error = nil;
    [delegate.managedObjectContext save:&error];
    if (error) {
        [NSException raise:@"删除错误" format:@"%@", [error localizedDescription]];
    }
    [CoreDataMngTool sharedCoredataMngTool].allMusicList = nil;
}

+(void)deleteMusic:(Music *)music{
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext deleteObject:music];
    
    NSError *error = nil;
    [delegate.managedObjectContext save:&error];
    if (error) {
        [NSException raise:@"删除错误" format:@"%@", [error localizedDescription]];
    }
    [CoreDataMngTool sharedCoredataMngTool].allMusicList = nil;
}

+(NSArray *)searchPersonsWithKeyString:(NSString *)keyString{
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"CoredataContact" inManagedObjectContext:delegate.managedObjectContext];
    request.entity = desc;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", keyString];
    request.predicate = predicate;
                              
    NSError *error = nil;
    NSArray *objs = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    return objs;
    
}

//当歌曲以任意形式切换时 都会调用这个设置当前播放音乐的方法
-(void)setCurMusic:(Music *)curMusic{
    //_curMusic 保存的现在正在播放的歌曲，参数curMusic传入的是将要播放的歌曲
    if (curMusic != nil) {
        _oldMusic = _curMusic;
        if (_oldMusic != nil) {
            _oldMusic.isPlay = NO;
        }
        _curMusic = curMusic;
        _curMusic.isPlay = YES;
    }else{
        _curMusic = curMusic;
    }
}

-(Music *)nextMusic{
    
    if (self.curPlayList != nil && self.curPlayList.count != 0) {
        if (self.curMusic == nil) {
            Music* nextMusic = self.curPlayList[0];
            return nextMusic;
        }else{
            NSUInteger curMusicIndex = [self.curPlayList indexOfObject:self.curMusic];
            if (curMusicIndex == self.curPlayList.count-1) {
                curMusicIndex = 0;
            }else{
                curMusicIndex++;
            }
            if (curMusicIndex <= self.curPlayList.count-1) {
                Music* nextMusic = self.curPlayList[curMusicIndex];
                return nextMusic;
            }else{
                return nil;
            }
        }
    }else{
        return nil;
    }
}


/****************************************************/
/******** 播放列表相关的函数 ***************************/
/****************************************************/
+(NSArray*)searchSaveNames{
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"SaveList" inManagedObjectContext:delegate.managedObjectContext];
    request.entity = desc;
    
    //    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
    //    request.sortDescriptors = [NSArray arrayWithObject:sort];
    
    NSError *error = nil;
    NSArray *objs = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    return objs;
}

+(NSArray *)serachSaveNameListWithName:(NSString*)saveName{
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *desc = [NSEntityDescription entityForName:@"SaveList" inManagedObjectContext:delegate.managedObjectContext];
    request.entity = desc;
    
    //查询条件的设置
    NSString* conditon = [NSString stringWithFormat:@"name LIKE '%@'", saveName];
    NSPredicate * qcondition= [NSPredicate predicateWithFormat:conditon];
    request.predicate = qcondition;
    
    NSError *error = nil;
    NSArray *objs = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    return objs;
    
}


-(NSArray *)saveNameList{
    if (_saveNameList == nil) {
        _saveNameList = [[CoreDataMngTool searchSaveNames] mutableCopy];
    }
    return _saveNameList;
}


-(BOOL)addSaveList:(NSString *)saveListName{
    if (saveListName == nil) {
        return YES;
    }
    
    if ([CoreDataMngTool serachSaveNameListWithName:saveListName].count != 0) {
        return NO;
    }

    NSDictionary* dict = @{@"name":saveListName};
    //播放模型的创建，同时已经存储到coredata数据库中了
    [SaveList saveListWithDict:dict];
    [CoreDataMngTool sharedCoredataMngTool].saveNameList = nil;
    return YES;
}

+(void)deleteSaveList:(SaveList *)saveList{
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext deleteObject:saveList];
    [[CoreDataMngTool sharedCoredataMngTool].saveNameList removeObject:saveList];
    
    NSError *error = nil;
    [delegate.managedObjectContext save:&error];
    if (error) {
        [NSException raise:@"删除错误" format:@"%@", [error localizedDescription]];
    }
    //[CoreDataMngTool sharedCoredataMngTool].saveNameList = nil;
}

@end
