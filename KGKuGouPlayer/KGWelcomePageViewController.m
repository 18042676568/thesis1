//
//  KGWelcomePageViewController.m
//  KGKuGouPlayer
//
//  Created by hegf on 15/9/15.
//  Copyright (c) 2015年 hegf. All rights reserved.
//

#import "KGWelcomePageViewController.h"
#import "KGHomePageViewController.h"

#define kStartButtonCenterYRatio 470.f/667.f
#define kPageControlCenterYRatio 617.f/667.f

@interface KGWelcomePageViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrowView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation KGWelcomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //scrowView填充屏幕
    _scrowView.frame = [UIScreen mainScreen].bounds;
    //让pageControl处于屏幕的637.f/667.f比例的位置
    _pageControl.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, kPageControlCenterYRatio*[UIScreen mainScreen].bounds.size.height);
    
    //设置scrowView 包括显示的图片以及contentSize等
    [self setupScrowView];
    
    //设置pageControl的数量
    _pageControl.numberOfPages = 5;
}

#pragma mark 设置scrowView 包括显示的图片以及contentSize等
-(void)setupScrowView{
    
    for (int i=0; i<5; i++) {
        UIImageView* imageView = [[UIImageView alloc]init];
        NSString* imageName = [NSString stringWithFormat:@"introduction_%i", i+1];
        [imageView setImage:[UIImage imageNamed:imageName]];
        imageView.frame = CGRectMake(i*[UIScreen mainScreen].bounds.size.width, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        if (i==4) {
            //添加开启音乐之旅按钮
            [self addStartButton:imageView];
        }
        
        [_scrowView addSubview:imageView];
    }
    _scrowView.contentSize = CGSizeMake(5*[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    _scrowView.pagingEnabled = YES;
    
    _scrowView.bounces = NO;
    
}

#pragma mark 添加开启音乐之旅按钮
-(void)addStartButton:(UIImageView*) imageView{
    
    imageView.userInteractionEnabled = YES;
    
    UIButton* startButton = [[UIButton alloc]init];
    startButton.bounds = CGRectMake(0, 0, 122, 32);
    startButton.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5f, [UIScreen mainScreen].bounds.size.height*kStartButtonCenterYRatio);
    
    [startButton setBackgroundImage:[UIImage imageNamed:@"introduction_enter_nomal"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"introduction_enter_press"] forState:UIControlStateHighlighted];
    
    //startButton.backgroundColor = [UIColor redColor];
    [imageView addSubview:startButton];
    
    
    [startButton addTarget:self action:@selector(startMusicChip:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 开启音乐之旅
-(void)startMusicChip:(UIButton*)sender{
    //直接讲主页设置为window的rootViewContorller 这样就不会再回到欢迎页
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    UINavigationController* homeVC = [storyBoard instantiateViewControllerWithIdentifier:@"homePage"];
    
    [UIApplication sharedApplication].keyWindow.rootViewController = homeVC;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSUInteger number =  (NSUInteger)_scrowView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    _pageControl.currentPage = number;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
