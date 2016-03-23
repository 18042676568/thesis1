//
//  UIImage+MoreExtensions.m
//  UI14-QQ聊天界面
//
//  Created by hegf on 15/8/26.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "UIImage+MoreExtensions.h"

@implementation UIImage (MoreExtensions)

+(instancetype)resizeableImageNamed:(NSString *)imageName{
    //人为的做出一个UIImage 这个image 只拉伸中间的像素点。边缘的形状保持不变！
    UIImage *image = [UIImage imageNamed:imageName];
    //UIEdgeInsets 传入的是拉伸的那个方框 一般是设置成图片的中心点
    //NSLog(@"%@", NSStringFromCGSize(image.size));
    UIImage* resizableImage = [image resizableImageWithCapInsets: UIEdgeInsetsMake(image.size.height*0.5, image.size.width*0.5, image.size.height*0.5, image.size.width*0.5)];
    return resizableImage;
}

@end
