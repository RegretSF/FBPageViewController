//
//  FBPageTitleView.h
//  PageView
//
//  Created by tq001 on 2019/9/29.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSArray+FBExtension.h"

NS_ASSUME_NONNULL_BEGIN
@class FBPageTitleView;

@protocol FBPageTitleViewDelegate <NSObject>

/// 点击 item 的时候
/// @param pageTitleView FBPageTitleView
/// @param index label 的 tag
- (void)pageTitleView:(FBPageTitleView *)pageTitleView selectedIndex:(NSInteger)index;

@end

@interface FBPageTitleView : UIView
@property(nonatomic, weak) id<FBPageTitleViewDelegate> delegate;

/// 标题数组
@property(nonatomic, strong) NSArray<NSString *> *titles;
/// 标题大小
@property(nonatomic, assign) CGFloat titleFontSize;
/// 标题默认颜色
@property(nonatomic, strong) UIColor *normalColor;
/// 标题选中颜色
@property(nonatomic, strong) UIColor *selectColor;
/// 滑块的颜色
@property(nonatomic, strong) UIColor *sliderColor;

/// 设置 title
/// @param progress 进程
/// @param sourceIndex 源索引
/// @param targetIndex 目标索引
- (void)setTitleWithProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex;

/// 自定义初始化方法
/// @param frame frame
/// @param titles 标题数组
- (instancetype)initWithFrame:(CGRect)frame titles:(nullable NSArray<NSString *> *)titles;

@end

NS_ASSUME_NONNULL_END
