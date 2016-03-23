//
//  NSString+DateTransform.m
//  UI14-QQ聊天界面
//
//  Created by hegf on 15/8/27.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "NSString+DateTransform.h"

@implementation NSString (DateTransform)
+(instancetype)HMSWithDate:(NSDate *)date{
    if (date == nil) {
        date = [NSDate date];
    }
    //辅助我们取时间的类，通过它设置想要取得时间的格式，来返回给你相应格式的时间
    NSDateFormatter* formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"HH:mm:ss"];
    NSString* dateString = [formater stringFromDate:date];
    return dateString;
}

+(instancetype)HMWithDate:(NSDate *)date{
    if (date == nil) {
        date = [NSDate date];
    }
    
    //辅助我们取时间的类，通过它设置想要取得时间的格式，来返回给你相应格式的时间
    NSDateFormatter* formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"HH:mm"];
    NSString* dateString = [formater stringFromDate:date];
    return dateString;
}

+(instancetype)YMDithDate:(NSDate *)date{
    if (date == nil) {
        date = [NSDate date];
    }
    //辅助我们取时间的类，通过它设置想要取得时间的格式，来返回给你相应格式的时间
    NSDateFormatter* formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString* dateString = [formater stringFromDate:date];
    return dateString;
}

@end
