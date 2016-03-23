//
//  Music.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "Music.h"
#import "AppDelegate.h"

@implementation Music

@dynamic name;
@dynamic index;
@dynamic singer;
@dynamic time;
@dynamic menuHidden;
@dynamic isPlay;
@dynamic isMylove;

+(instancetype)musicWithDict:(NSDictionary *)dict{
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    
    Music *music = [NSEntityDescription insertNewObjectForEntityForName:@"Music" inManagedObjectContext:delegate.managedObjectContext];
    
    music.name = [dict objectForKey:@"name"];
    music.index = [dict objectForKey:@"index"];
    music.singer = [dict objectForKey:@"singer"];
    music.time = [dict objectForKey:@"time"];
    
    music.menuHidden = YES;
    music.isPlay = NO;
    music.isMylove = NO;
    
    [delegate saveContext];
    
    return music;
}

@end
