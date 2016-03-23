//
//  KGMusicMenu.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "KGMusicMenu.h"
#import "UIView+Extension.h"
#import "NEUButton.h"

@implementation KGMusicMenu

+(instancetype)musicMenuWithInfos:(NSArray *)infoArray{
    KGMusicMenu* menu = [[KGMusicMenu alloc]init];
    if (menu) {
        menu.backgroundColor = [UIColor colorWithRed:61.f/255.f green:61.f/255.f blue:61.f/255.f alpha:1.0f];
        [menu setupSubViews:infoArray];
    }
    return menu;
}

#pragma mark 添加子控件
-(void)setupSubViews:(NSArray*)infoArray{
    for (int i=0; i<infoArray.count; i++) {
        NEUButton* button1 = [[NEUButton alloc]init];
        NSDictionary* dict = infoArray[i];
        [button1 setTitle:dict[@"title"] forState:UIControlStateNormal];
        [button1 setImage:[UIImage imageNamed:dict[@"image"]] forState:UIControlStateNormal];
        [self addSubview:button1];
        
        [button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark 按钮点击响应函数
-(void)buttonClicked:(NEUButton*)sender{
    if ([_delegate respondsToSelector:@selector(musicMenu:didButtonClicked:)]) {
        [_delegate musicMenu:self didButtonClicked:[sender titleForState:UIControlStateNormal]];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat buttonW = [UIScreen mainScreen].bounds.size.width/self.subviews.count;
    CGFloat buttonY = 0.f;
    CGFloat buttonH = self.height;
    
    NSUInteger index = 0;
    for (UIButton* button in self.subviews) {
        CGFloat buttonX = index*buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        index++;
    }
}

@end
