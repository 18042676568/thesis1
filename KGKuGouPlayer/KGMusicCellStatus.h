//
//  KGMusicCellStatus.h
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KGMusicCellStatus : NSObject
@property (assign, nonatomic) BOOL selected;

+(instancetype)musicCellStatusWithDict:(NSDictionary*)dict;
@end
