//
//  HomeViewController.m
//  NetEaseNews
//
//  Created by 张家欢 on 16/7/20.
//  Copyright © 2016年 zhangjiahuan. All rights reserved.
//

#import "HomeViewController.h"
#import "NewsViewController.h"

#define kButtonWidth 80
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

@interface HomeViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) NSArray *titlesArr;
@property (nonatomic,strong) UIScrollView *menuScrollView;
@property (nonatomic,strong) UIScrollView *bigScrollView;
@property (nonatomic,strong) UIButton *lastButton;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self creatSubviews];
    [self addChildController];
}
- (void)creatSubviews{
    _titlesArr = @[@"要闻",@"体育",@"娱乐",@"科技",@"视频",@"经济",@"军事",@"文化",@"微博"];
    
    _menuScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 40)];
    _menuScrollView.contentSize = CGSizeMake(kButtonWidth * _titlesArr.count, 40);
    _menuScrollView.showsHorizontalScrollIndicator = NO;
    _menuScrollView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_menuScrollView];
    
    _bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+40, kScreenWidth, kScreenHeight-64-40)];
    _bigScrollView.backgroundColor = [UIColor whiteColor];
    _bigScrollView.contentSize = CGSizeMake(kScreenWidth*_titlesArr.count, _bigScrollView.bounds.size.height);
    _bigScrollView.showsHorizontalScrollIndicator = NO;
    _bigScrollView.showsVerticalScrollIndicator = NO;
    _bigScrollView.pagingEnabled = YES;
    _bigScrollView.delegate = self;
    [self.view addSubview:_bigScrollView];
    
    for (NSInteger i = 0; i < _titlesArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*kButtonWidth, 0, kButtonWidth, 40);
        [button setTitle:_titlesArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.tag = i;
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            button.selected = YES;
            _lastButton = button;
        }
        [self.menuScrollView addSubview:button];
    }
}

- (void)addChildController{
    for (NSInteger i = 0; i < self.titlesArr.count; i++) {
        NewsViewController *newsVC = [[NewsViewController alloc] init];
        newsVC.title = self.titlesArr[i];
        newsVC.newsType = i;
        newsVC.newsStr = self.titlesArr[i];
        [self addChildViewController:newsVC];
    }
    
    // 添加默认控制器
    NewsViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.bigScrollView.bounds;
    [self.bigScrollView addSubview:vc.view];
}

- (void)clickButton:(UIButton *)button{
    _lastButton.selected = NO;
    button.selected = YES;
    _lastButton = button;
    //上方小的滑动视图的滚动
    float xx = kScreenWidth * (button.tag - 1) * (kButtonWidth / kScreenWidth) - kButtonWidth;
    [_menuScrollView scrollRectToVisible:CGRectMake(xx, 0, kScreenWidth, _menuScrollView.frame.size.height) animated:YES];
    
    //下方大的滑动视图的滚动
    CGFloat offsetX = button.tag * self.bigScrollView.frame.size.width;
    CGFloat offsetY = self.bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    [self.bigScrollView setContentOffset:offset animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSUInteger index = scrollView.contentOffset.x / self.bigScrollView.frame.size.width;
    _lastButton.selected = NO;
    UIButton *button = _menuScrollView.subviews[index];
    button.selected = YES;
    _lastButton = button;
    NewsViewController *newsVC = self.childViewControllers[index];
    if (newsVC.view.superview) return;
    newsVC.view.frame = scrollView.bounds;
    [self.bigScrollView addSubview:newsVC.view];
}


/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    float xx = scrollView.contentOffset.x * (kButtonWidth / kScreenWidth) - kButtonWidth;
    [_menuScrollView scrollRectToVisible:CGRectMake(xx, 0, kScreenWidth, _menuScrollView.frame.size.height) animated:YES];
}
@end
