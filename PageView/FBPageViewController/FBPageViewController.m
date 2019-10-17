//
//  FBPageViewController.m
//  PageView
//
//  Created by Mac on 2019/10/17.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import "FBPageViewController.h"

#define kStatusBarH \
({\
    CGFloat statusBarH;\
    if (@available(iOS 13.0,*)) {\
        statusBarH = [UIApplication sharedApplication].delegate.window.windowScene.statusBarManager.statusBarFrame.size.height;\
    }else {\
        statusBarH = [UIApplication sharedApplication].statusBarFrame.size.height;\
    }\
    (statusBarH);\
})\


@implementation FBPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // 3.自动布局
    NSDictionary *viewDict = @{@"pageTitleView": self.pageTitleView,
                               @"pageContentView": self.pageContentView};
    NSDictionary *metrics = @{@"naviH": @(44 + kStatusBarH), @"pageTitleViewHeight": @(self.pageTitleViewHeight)};
    // 标题视图
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-0-[pageTitleView]-0-|"
                               options:0
                               metrics:metrics
                               views:viewDict]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-(naviH)-[pageTitleView(pageTitleViewHeight)]"
                               options:0
                               metrics:metrics
                               views:viewDict]];
    // 内容视图
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-0-[pageContentView]-0-|"
                               options:0
                               metrics:metrics
                               views:viewDict]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:[pageTitleView]-0-[pageContentView]-0-|"
                               options:0
                               metrics:metrics
                               views:viewDict]];
}

#pragma mark setter
- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    self.pageTitleView.titles = titles;
}

- (void)setChildVCs:(NSArray<UIViewController *> *)childVCs {
    _childVCs = childVCs;
    self.pageContentView.childVCs = childVCs;
}

- (void)setTitleFontSize:(CGFloat)titleFontSize {
    _titleFontSize = titleFontSize;
    self.pageTitleView.titleFontSize = titleFontSize;
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    self.pageTitleView.normalColor = normalColor;
}

- (void)setSelectColor:(UIColor *)selectColor {
    _selectColor = selectColor;
    self.pageTitleView.selectColor = selectColor;
}

- (void)setSliderColor:(UIColor *)sliderColor {
    _sliderColor = sliderColor;
    self.pageTitleView.sliderColor = sliderColor;
}

#pragma mark 设置UI界面
- (void)setupUI {
    // 1.添加控件
    [self.view addSubview:self.pageTitleView];
    [self.view addSubview:self.pageContentView];
    
    // 设置代理
    self.pageContentView.delegate = self;
    self.pageTitleView.delegate = self;
    
    // 2.取消 autoresizing
    for (UIView *subview in self.view.subviews) {
        subview.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
}

#pragma mark FBPageContentViewDelegate
- (void)pageContentView:(FBPageContentView *)contentView progress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setTitleWithProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
}

#pragma mark FBPageTitleViewDelegate
- (void)pageTitleView:(FBPageTitleView *)pageTitleView selectedIndex:(NSInteger)index {
    [self.pageContentView setCurrentIndex:index];
}

#pragma mark 懒加载
- (FBPageContentView *)pageContentView {
    if (!_pageContentView) {
        _pageContentView = [[FBPageContentView alloc] initWithFrame:CGRectZero
                                               parentViewController:self
                                                           childVCs:nil];
    }
    return _pageContentView;
}

- (FBPageTitleView *)pageTitleView {
    if (!_pageTitleView) {
        _pageTitleView = [[FBPageTitleView alloc] initWithFrame:CGRectZero titles:nil];
    }
    return _pageTitleView;
}
@end
