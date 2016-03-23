//
//  NEUButton.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/22.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "NEUButton.h"

@implementation NEUButton

//返回button的image的位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect{

    CGFloat newRectX = (CGRectGetWidth(contentRect) - 30.f)*0.5;
    CGFloat newRectY = 8.f;
    CGRect newRect = CGRectMake(newRectX, newRectY, 30.f, 30.f);
    return newRect;
    
}

//返回button的title的位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect{

    CGRect titleRect = [super titleRectForContentRect:contentRect];
    
    CGFloat newRectX = (CGRectGetWidth(contentRect) - CGRectGetWidth(titleRect))*0.5;
    CGFloat newRectY = (CGRectGetHeight(contentRect) - 38.f - CGRectGetHeight(titleRect))*0.5+38.f;
    CGFloat newRectW = CGRectGetWidth(titleRect);
    CGFloat newRectH = CGRectGetHeight(titleRect);
    
    CGRect newRect = CGRectMake(newRectX, newRectY, newRectW, newRectH);
    return newRect;
}

@end
