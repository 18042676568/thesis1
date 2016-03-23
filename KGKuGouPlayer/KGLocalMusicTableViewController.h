//
//  KGLocalMusicTableViewController.h
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/18.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "KGMusicTableViewCell.h"

@interface KGLocalMusicTableViewController : UITableViewController<AVAudioPlayerDelegate,KGMusicTableViewCellDelegate, UIActionSheetDelegate>

@end
