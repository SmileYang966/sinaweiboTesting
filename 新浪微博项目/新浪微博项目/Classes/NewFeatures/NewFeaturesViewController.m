//
//  NewFeaturesViewController.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/31.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "NewFeaturesViewController.h"
#import "Masonry.h"

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
    
    //1.添加imageView到scrollView上
    for (int i = 0; i<4; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.x = self.view.bounds.size.width * i;
        imgView.y = 0;
        imgView.width = self.view.bounds.size.width;
        imgView.height = self.view.bounds.size.height;
        [self.scrollView addSubview:imgView];
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"launch%d",i+1]];
    }
    
    //2.添加UIPageControl到屏幕上
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(100, 600,100,40)];
    pageControl.centerX = self.view.centerX;
    pageControl.numberOfPages = 4;
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"content offset is %@",NSStringFromCGPoint(scrollView.contentOffset));
    self.pageControl.currentPage =  scrollView.contentOffset.x / self.view.bounds.size.width;
}

@end
