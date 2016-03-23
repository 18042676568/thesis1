//
//  KGMusicMenu.h
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/21.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KGMusicMenu;

@protocol KGMusicMenuDelegate<NSObject>
@optional
-(void)musicMenu:(KGMusicMenu*)musicMenu didButtonClicked:(NSString*)title;
@end

@interface KGMusicMenu : UIView

+(instancetype)musicMenuWithInfos:(NSArray*)infoArray;

@property (weak, nonatomic) id<KGMusicMenuDelegate> delegate;

@end
