//
//  KGPlayBar.h
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Music.h"

@class KGPlayBar;
@protocol KGPlayBarDelegate <NSObject>

-(void)playBar:(KGPlayBar*)playBar didPlayPauseMusic:(BOOL)playMethod;
-(void)playBarDidPlayNextMusic:(KGPlayBar*)playBar;

@end


@interface KGPlayBar : UIView
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UILabel *musicName;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UILabel *singer;
- (IBAction)playPauseMusic:(UIButton*)sender;
- (IBAction)Playnext:(UIButton*)sender;

+(instancetype)playBar;

@property (strong, nonatomic) Music* music;

@property (weak, nonatomic) id<KGPlayBarDelegate> delegate;

@end
