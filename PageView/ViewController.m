//
//  ViewController.m
//  PageView
//
//  Created by tq001 on 2019/9/29.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import "ViewController.h"
#import "FBPageTitleView.h"
#import "FBPageContentView.h"
#import "UIColor+FBExtension.h"
#import "DTPageViewController.h"

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

@interface ViewController () <FBPageContentViewDelegate, FBPageTitleViewDelegate>
@property(nonatomic, strong) NSArray<NSString *> *titles;
@property(nonatomic, strong) FBPageTitleView *pageTitleView;
@property(nonatomic, strong) FBPageContentView *pageContentView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
//    self.titles = @[@"萨达", @"广费", @"热点", @"新r", @"最新", @"体育", @"明星", @"同城", @"军事", @"历史", @"时尚", @"离开"];
//
//    self.pageTitleView.titles = self.titles;
//
//    NSMutableArray *childVCs = [NSMutableArray array];
//    for (int i = 0; i < self.titles.count; i++) {
//        UIViewController *vc = [[UIViewController alloc] init];
//        vc.view.backgroundColor = [UIColor randomColor];
//        [childVCs addObject:vc];
//    }
//    self.pageContentView.childVCs = childVCs;
//
//    // 1.添加控件
//    [self.view addSubview:self.pageTitleView];
//    [self.view addSubview:self.pageContentView];
//
//    // 设置代理
//    self.pageContentView.delegate = self;
//    self.pageTitleView.delegate = self;
//
//    // 2.取消 autoresizing
//    for (UIView *subview in self.view.subviews) {
//        subview.translatesAutoresizingMaskIntoConstraints = NO;
//    }
//
//    // 3.自动布局
//    NSDictionary *viewDict = @{@"pageTitleView": self.pageTitleView,
//                               @"pageContentView": self.pageContentView};
//    NSDictionary *metrics = @{@"naviH": @(44 + kStatusBarH)};
//    // 标题视图
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"H:|-0-[pageTitleView]-0-|"
//                               options:0
//                               metrics:metrics
//                               views:viewDict]];
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"V:|-(naviH)-[pageTitleView(44)]"
//                               options:0
//                               metrics:metrics
//                               views:viewDict]];
//    // 内容视图
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"H:|-0-[pageContentView]-0-|"
//                               options:0
//                               metrics:metrics
//                               views:viewDict]];
//    [self.view addConstraints:[NSLayoutConstraint
//                               constraintsWithVisualFormat:@"V:[pageTitleView]-0-[pageContentView]-0-|"
//                               options:0
//                               metrics:metrics
//                               views:viewDict]];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    DTPageViewController *pageViewController = [[DTPageViewController alloc] init];
    [self.navigationController pushViewController:pageViewController animated:YES];
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
        _pageTitleView.titleFontSize = 17;
    }
    return _pageTitleView;
}

@end
