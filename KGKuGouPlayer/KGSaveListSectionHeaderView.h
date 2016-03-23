//
//  KGSaveListSectionHeaderView.h
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/29.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveList.h"

@class KGSaveListSectionHeaderView;
@protocol KGSaveListSectionHeaderViewDelegate <NSObject>

@optional
-(void)saveListSectionHeaderViewdidDeleteButtonClicked:(KGSaveListSectionHeaderView*)headerView;

@end
@interface KGSaveListSectionHeaderView : UIView
@property (weak, nonatomic) UILabel* title;
@property (weak, nonatomic) UIButton* deleteButton;
@property (strong ,nonatomic) SaveList* saveList;

+(instancetype)saveListSectionHeaderView;

@property (weak, nonatomic) id<KGSaveListSectionHeaderViewDelegate>delegate;

@end
