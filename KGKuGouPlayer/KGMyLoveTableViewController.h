//
//  KGMyLoveTableViewController.h
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/24.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGMusicTableViewCell.h"
#import <AVFoundation/AVFoundation.h>

@interface KGMyLoveTableViewController : UITableViewController<AVAudioPlayerDelegate,KGMusicTableViewCellDelegate, UIActionSheetDelegate>

@end
