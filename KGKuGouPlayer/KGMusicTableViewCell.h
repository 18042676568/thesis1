//
//  KGMusicTableViewCell.h
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Music.h"
#import "KGMusicMenu.h"

@class KGMusicTableViewCell;
@protocol KGMusicTableViewCellDelegate<NSObject>
@optional
-(void)musicTableViewCell:(KGMusicTableViewCell*)cell didShowHiddenMenu:(BOOL)show;
-(void)musicTableViewCell:(KGMusicTableViewCell*)cell didButtonClicked:(NSString*)title;

@end

@interface KGMusicTableViewCell : UITableViewCell<KGMusicMenuDelegate>

@property (weak, nonatomic) UIButton* addButton;
@property (weak, nonatomic) UILabel* musicName;
@property (weak, nonatomic) UIButton* mvButton;
@property (weak, nonatomic) UIButton* moreButton;
@property (weak, nonatomic) UIView* background;

+(instancetype)musicTableViewCellWithTableView:(UITableView*)tableView;

@property (strong, nonatomic) Music* music;

@property (weak, nonatomic) id<KGMusicTableViewCellDelegate> delegate;

@end
