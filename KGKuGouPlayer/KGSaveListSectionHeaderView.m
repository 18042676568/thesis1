//
//  KGSaveListSectionHeaderView.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/29.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "KGSaveListSectionHeaderView.h"
#import "UIView+Extension.h"

@implementation KGSaveListSectionHeaderView

+(instancetype)saveListSectionHeaderView{
    KGSaveListSectionHeaderView* view = [[KGSaveListSectionHeaderView alloc]init];
    view.frame = CGRectMake(0.f, 0.f, [UIScreen mainScreen].bounds.size.width, 44.f);
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        UILabel* title = [[UILabel alloc]init];
        _title = title;
        [self addSubview:title];
        
        UIButton* deleteButton = [[UIButton alloc]init];
        _deleteButton = deleteButton;
        [self addSubview:deleteButton];
        [deleteButton addTarget:self action:@selector(deleteButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [deleteButton setTitleColor:[UIColor yellowColor] forState:UIControlStateHighlighted];
    }
    return self;
}

-(void)deleteButtonClicked:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(saveListSectionHeaderViewdidDeleteButtonClicked:)]) {
        [_delegate saveListSectionHeaderViewdidDeleteButtonClicked:self];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _title.frame = CGRectMake(8.f, 7.f, self.frame.size.width-54.f, 30.f);
    _deleteButton.frame = CGRectMake(_title.right+8.f, _title.top, 30.f, 30.f);

}

-(void)setSaveList:(SaveList *)saveList{
    _saveList = saveList;
    _title.text = saveList.name;
}

@end
