//
//  FBPageViewController.h
//  PageView
//
//  Created by Mac on 2019/10/17.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBPageTitleView.h"
#import "FBPageContentView.h"

NS_ASSUME_NONNULL_BEGIN

@interface FBPageViewController : UIViewController <FBPageContentViewDelegate, FBPageTitleViewDelegate>

@property(nonatomic, strong) FBPageTitleView *pageTitleView;
@property(nonatomic, strong) FBPageContentView *pageContentView;

/// 标题数组
@property(nonatomic, strong) NSArray<NSString *> *titles;
/// 子视图控制器数组，设置的时候需与标题数组的个数一致
@property(nonatomic, strong) NSArray<UIViewController *> *childVCs;
/// 标题视图的高度
@property(nonatomic, assign) CGFloat pageTitleViewHeight;
/// pageTitleView 中字体的大小
@property(nonatomic, assign) CGFloat titleFontSize;
/// 标题默认颜色
@property(nonatomic, strong) UIColor *normalColor;
/// 标题选中颜色
@property(nonatomic, strong) UIColor *selectColor;
/// 滑块的颜色
@property(nonatomic, strong) UIColor *sliderColor;
@end

NS_ASSUME_NONNULL_END
