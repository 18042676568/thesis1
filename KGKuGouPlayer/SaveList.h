//
//  SaveList.h
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SaveList : NSManagedObject

@property (nonatomic, retain) NSString * name;

+(instancetype)saveListWithDict:(NSDictionary *)dict;
@end
