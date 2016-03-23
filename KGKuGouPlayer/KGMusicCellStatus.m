//
//  KGMusicCellStatus.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "KGMusicCellStatus.h"

@implementation KGMusicCellStatus

+(instancetype)musicCellStatusWithDict:(NSDictionary *)dict{
    KGMusicCellStatus* status = [[KGMusicCellStatus alloc]init];
    if (status) {
        [status setValuesForKeysWithDictionary:dict];
    }
    return status;
}

@end
