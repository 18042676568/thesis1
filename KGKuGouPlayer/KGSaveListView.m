//
//  KGSaveListView.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/28.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "KGSaveListView.h"
#import "UIView+Extension.h"

#define Margin 20.f
#define MidMargin 8.f

@implementation KGSaveListView

+(instancetype)saveListView{
    KGSaveListView* saveListView = [[KGSaveListView alloc]init];
    
    saveListView.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width*0.6, 108.f);
    saveListView.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, [UIScreen mainScreen].bounds.size.height*0.5);
    saveListView.backgroundColor = [UIColor lightGrayColor];
    return saveListView;
}

//添加子控件
-(instancetype)init{
    self = [super init];
    if (self) {
        
        //view的四个边是圆弧状
        self.layer.cornerRadius = 20.f;
        
        UITextField* saveListName = [[UITextField alloc]init];
        _saveListName = saveListName;\
        saveListName.text = @"默认列表";
        [self addSubview:saveListName];
        saveListName.backgroundColor = [UIColor whiteColor];
        saveListName.borderStyle = UITextBorderStyleRoundedRect;
        
        UIButton* okButton = [[UIButton alloc]init];
        _okButton = okButton;
        
        okButton.layer.borderColor = [[UIColor yellowColor] CGColor];
        okButton.layer.borderWidth = 2.0;
        okButton.layer.cornerRadius = 15.f;
        
        okButton.backgroundColor = [UIColor blueColor];
        [self addSubview:okButton];
        [okButton setTitle:@"确定" forState:UIControlStateNormal];
        
        [okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [okButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        
        [okButton addTarget:self action:@selector(okButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton* cancelButton = [[UIButton alloc]init];
        _cancelButton = cancelButton;
        cancelButton.backgroundColor = [UIColor redColor];
        [self addSubview:cancelButton];
        [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cacelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

//定义子控件的位置
-(void)layoutSubviews{
    [super layoutSubviews];
    _saveListName.frame = CGRectMake(Margin, Margin, self.frame.size.width-2*Margin, 30.f);
    
    _cancelButton.frame = CGRectMake(_saveListName.left, _saveListName.bottom+MidMargin, (_saveListName.width-MidMargin)*0.5, 30.f);
    
    _okButton.frame = CGRectMake(_cancelButton.right+MidMargin, _cancelButton.top, _cancelButton.width, _cancelButton.height);
}

#pragma mark 确定添加
-(void)okButtonClicked:(UIButton*)sender{
    if (_saveListName.text.length == 0) {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"输入列表" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    if ([_delegate respondsToSelector:@selector(saveListView:didSaveListNameConfirm:)]) {
        [_delegate saveListView:self didSaveListNameConfirm:_saveListName.text];
    }
}

#pragma mark 取消添加
-(void)cacelButtonClicked:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(saveListView:didSaveListNameConfirm:)]) {
        [_delegate saveListView:self didSaveListNameConfirm:nil];
    }
}

-(void)showinView:(UIView *)view{
    UIView* mengBorad = [[UIView alloc]init];
    _mengBoard = mengBorad;
    mengBorad.frame = [UIScreen mainScreen].bounds;
    mengBorad.backgroundColor = [UIColor yellowColor];
    mengBorad.alpha = 0.3;
    [view addSubview:mengBorad];
    [view addSubview:self];
}

-(void)hide{
    [_mengBoard removeFromSuperview];
    [self removeFromSuperview];
}

@end
