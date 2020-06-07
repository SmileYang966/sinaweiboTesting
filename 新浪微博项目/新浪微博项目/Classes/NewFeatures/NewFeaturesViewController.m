//
//  NewFeaturesViewController.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/31.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "NewFeaturesViewController.h"
#import "Masonry.h"
#import "SCTabBarViewController.h"

@interface NewFeaturesViewController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong) UIPageControl *pageControl;

@end

@implementation NewFeaturesViewController

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_scrollView];
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*4,0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    int pageCount = 4;
    //1.添加imageView到scrollView上
    for (int i = 0; i<pageCount; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.x = self.view.bounds.size.width * i;
        imgView.y = 0;
        imgView.width = self.view.bounds.size.width;
        imgView.height = self.view.bounds.size.height;
        [self.scrollView addSubview:imgView];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"launch%d",i+1]];
        
        //处理最后一个imageView
        if (i == pageCount-1) {
            [self setupLastImgeView:imgView];
        }
    }
    
    //2.添加UIPageControl到屏幕上
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(100, 600,100,40)];
    pageControl.centerX = self.view.centerX;
    pageControl.numberOfPages = 4;
    pageControl.pageIndicatorTintColor = UIColor.whiteColor;
    pageControl.currentPageIndicatorTintColor = UIColor.blueColor;
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
}


- (void)setupLastImgeView:(UIImageView *)lastImageView{
    lastImageView.userInteractionEnabled = YES;
    UIButton *startedButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0, 105, 36)];
    startedButton.centerY = lastImageView.height * 0.85f;
    startedButton.centerX = lastImageView.width * 0.5f;
    [lastImageView addSubview:startedButton];
    [startedButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startedButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateSelected];
    [startedButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startedButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [startedButton addTarget:self action:@selector(startedButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *shareButton = [[UIButton alloc]initWithFrame:CGRectMake(100,100, 200, 40)];
    [lastImageView addSubview:shareButton];
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    shareButton.imageEdgeInsets = UIEdgeInsetsMake(0,-10,0,0);
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0,10,0,0);
    [shareButton addTarget:self action:@selector(shareButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.centerY = lastImageView.height * 0.77f;
    shareButton.centerX = lastImageView.width * 0.5f;
}

-(void)startedButtonClicked:(UIButton *)startedButton{
    SCTabBarViewController *tabBarVC = [[SCTabBarViewController alloc]init];
    [UIApplication sharedApplication].windows.firstObject.rootViewController = tabBarVC;
}

-(void)shareButtonClicked:(UIButton *)sharedButton{
    sharedButton.selected = !sharedButton.selected;
    if (sharedButton.selected) {
        [sharedButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateNormal];
    }else{
        [sharedButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"content offset is %@",NSStringFromCGPoint(scrollView.contentOffset));
    self.pageControl.currentPage =  scrollView.contentOffset.x / self.view.bounds.size.width;
}

@end
