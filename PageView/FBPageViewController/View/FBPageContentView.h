//
//  FBPageContentView.h
//  PageView
//
//  Created by tq001 on 2019/9/29.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FBPageContentView;
@protocol FBPageContentViewDelegate <NSObject>
/// 滚动视图的时候
/// @param contentView FBPageContentView
/// @param progress 进程
/// @param sourceIndex 原索引
/// @param targetIndex 目标索引
- (void)pageContentView:(FBPageContentView *)contentView
               progress:(CGFloat)progress
            sourceIndex:(NSInteger)sourceIndex
            targetIndex:(NSInteger)targetIndex;

@end

@interface FBPageContentView : UIView
@property(nonatomic, weak) id<FBPageContentViewDelegate> delegate;

/// 父视图控制器
@property(nonatomic, weak) UIViewController *parentViewController;
/// 子视图控制器数组
@property(nonatomic, strong) NSArray< UIViewController *> *childVCs;

/// 设置当前内容视图
/// @param currentIndex 索引
- (void)setCurrentIndex:(NSInteger)currentIndex;

/// 自定义初始化方法
/// @param frame frame
/// @param parentViewController 父视图控制器
/// @param childVCs 子视图控制器
- (instancetype)initWithFrame:(CGRect)frame
         parentViewController:(UIViewController *)parentViewController
                     childVCs:(nullable NSArray<UIViewController *> *)childVCs;


@end

NS_ASSUME_NONNULL_END
