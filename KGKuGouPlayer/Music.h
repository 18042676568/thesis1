//
//  Music.h
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Music : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * index;
@property (nonatomic, retain) NSString * singer;
@property (nonatomic, retain) NSString * time;

@property (nonatomic, assign) BOOL menuHidden;
@property (nonatomic, assign) BOOL isPlay;
@property (nonatomic, assign) BOOL isMylove;

+(instancetype)musicWithDict:(NSDictionary *)dict;

@end
