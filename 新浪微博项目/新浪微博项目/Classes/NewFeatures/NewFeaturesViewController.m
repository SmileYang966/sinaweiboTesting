//
//  NewFeaturesViewController.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/31.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "NewFeaturesViewController.h"
#import "Masonry.h"

@interface NewFeaturesViewController ()

@property(nonatomic,strong)UIScrollView *scrollView;


@end

@implementation NewFeaturesViewController

- (UIScrollView *)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:_scrollView];
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width*4,0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
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
    
}


@end
