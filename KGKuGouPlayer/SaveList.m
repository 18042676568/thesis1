//
//  SaveList.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "SaveList.h"
#import "AppDelegate.h"

@implementation SaveList

@dynamic name;

+(instancetype)saveListWithDict:(NSDictionary *)dict{
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    SaveList *saveList = [NSEntityDescription insertNewObjectForEntityForName:@"SaveList" inManagedObjectContext:delegate.managedObjectContext];
    
    saveList.name = [dict objectForKey:@"name"];
    
    [delegate saveContext];
    
    return saveList;
}

@end
