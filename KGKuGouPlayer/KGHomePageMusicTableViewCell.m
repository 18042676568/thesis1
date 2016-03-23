//
//  KGHomePageMusicTableViewCell.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/17.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "KGHomePageMusicTableViewCell.h"

@implementation KGHomePageMusicTableViewCell

+(instancetype)homePageMusicTableViewCellWithTableView:(UITableView *)tableView{
    static NSString* ID = @"homeListcell";
    
    KGHomePageMusicTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[KGHomePageMusicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
//    cell.textLabel.text = @"TEST";
    cell.textLabel.textColor = [UIColor whiteColor];
    
    return cell;
}

-(void)setStatus:(KGMusicCellStatus *)status{
    if (status.selected) {
        self.textLabel.textColor = [UIColor orangeColor];
    }else{
        self.textLabel.textColor = [UIColor whiteColor];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
