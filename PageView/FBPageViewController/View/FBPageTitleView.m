//
//  FBPageTitleView.m
//  PageView
//
//  Created by tq001 on 2019/9/29.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import "FBPageTitleView.h"
#import "UIColor+FBExtension.h"
#import "UIView+FBExtension.h"

@interface FBPageTitleView () <UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIView *bottomLineViw;
@property(nonatomic, strong) UIView *sliderView;
@property(nonatomic, strong) NSMutableArray<UILabel *> *titleLabels;
@end

@implementation FBPageTitleView {
    /// 滑块的高度
    CGFloat _sliderH;
    /// 滑块的Y轴
    CGFloat _sliderY;
    /// 滚动内容视图的总偏移量
    CGFloat _scrollOffsetX;
    /// 滚动内容视图需要偏移的数
    CGFloat _contentOffsetMoveX;
    /// 记录当前选中的 item
    NSInteger _selectItem;
    
}
//颜色rgb的值


#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        [self setupUI];
    }
    return self;
}

/// 重新布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!self.titleLabels) { return; }
    
    // 1、设置 label 的frame
     __block CGFloat tempW = 0;
    [self.titleLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title = self.titles[idx];
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:self.titleFontSize]};
        CGFloat labelW = [title sizeWithAttributes:attrs].width + 30;
        tempW += labelW;
        obj.font = [UIFont systemFontOfSize:self.titleFontSize];
        obj.frame = CGRectMake(tempW - labelW, 0, labelW, self.cs_height - _sliderH);
        NSArray<NSNumber *> *normalRGB = [NSArray arrayToRGBWithColor:self.normalColor];
        obj.textColor = FBRGBColor(normalRGB[0].floatValue, normalRGB[1].floatValue, normalRGB[2].floatValue);
    }];
    
    // 2.设置 scrollView 内容视图的大小
    self.scrollView.contentSize = CGSizeMake(tempW, self.scrollView.cs_height);
    
    // 3.设置滑块
    self.sliderView.frame = CGRectMake(0, self.cs_height - _sliderH, self.titleLabels.firstObject.cs_width, _sliderH);
    NSArray<NSNumber *> *sliderRGB = [NSArray arrayToRGBWithColor:self.sliderColor];
    self.sliderView.backgroundColor = FBRGBColor(sliderRGB[0].floatValue, sliderRGB[1].floatValue, sliderRGB[2].floatValue);
    
    // 设置第一个标题的颜色
    NSArray<NSNumber *> *selectRGB = [NSArray arrayToRGBWithColor:self.selectColor];
    self.titleLabels.firstObject.textColor = FBRGBColor(selectRGB[0].floatValue, selectRGB[1].floatValue, selectRGB[2].floatValue);
}

#pragma mark 监听方法
- (void)titleLabelClick:(UITapGestureRecognizer *)tapGes {
    // 0.取出 label
    UILabel *currentLabel = (UILabel *)tapGes.view;
    UILabel *oldLabel = self.titleLabels[_selectItem];
    
    // 1.设置滑块的位置
    [UIView animateWithDuration:0.1 animations:^{
        self.sliderView.cs_x = currentLabel.cs_x;
        self.sliderView.cs_width = currentLabel.cs_width;
    }];
    
    // 2. 设置滚动内容视图的偏移量
    [self offsetScrollContentWithIndex:currentLabel.tag progress:1.0 animated:YES];

    // 3.切换文字的颜色
    NSArray<NSNumber *> *normalRGB = [NSArray arrayToRGBWithColor:self.normalColor];
    NSArray<NSNumber *> *selectRGB = [NSArray arrayToRGBWithColor:self.selectColor];
    if (currentLabel.tag != oldLabel.tag) {
        currentLabel.textColor = FBRGBColor(selectRGB[0].floatValue, selectRGB[1].floatValue, selectRGB[2].floatValue);
        oldLabel.textColor = FBRGBColor(normalRGB[0].floatValue, normalRGB[1].floatValue, normalRGB[2].floatValue);
    }else {
        oldLabel.textColor = FBRGBColor(selectRGB[0].floatValue, selectRGB[1].floatValue, selectRGB[2].floatValue);
    }
    
    // 4.保存最新Label的下标值
    _selectItem = currentLabel.tag;
    
    // 5.通知代理
    if ([self.delegate respondsToSelector:@selector(pageTitleView:selectedIndex:)]) {
        [self.delegate pageTitleView:self selectedIndex:currentLabel.tag];
    }
}

#pragma mark setter
- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    
    for (int i=0; i<self.titles.count; i++) {
        
        //1、创建UILabel
        UILabel *label = [[UILabel alloc] init];
        
        //2、设置label的一些属性
        label.text = self.titles[i];
        label.tag = i;
        label.font = [UIFont systemFontOfSize:16];
        label.textAlignment = NSTextAlignmentCenter;
        
        //3、将label添加到scrollView
        [self.scrollView addSubview:label];
        
        //4、给label添加手势
        //打开用户交互功能
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelClick:)];
        [label addGestureRecognizer:tapGes];
        
        //将UILabel添加到数组
        [self.titleLabels addObject:label];
    }
    
    // 调用该方法，重新布局
    [self layoutSubviews];
}

#pragma mark 设置UI界面
- (void)setupUI {
    self.bottomLineViw.backgroundColor = [UIColor lightGrayColor];
    
    _selectItem = 0;
    _sliderH = 3;
    _sliderView.layer.cornerRadius = 1.5;
    _sliderView.layer.masksToBounds = YES;
    
    // 1.添加控件
    //1、添加scrollView
    [self addSubview:self.scrollView];
    [self addSubview:self.bottomLineViw];
    [self.scrollView addSubview:self.sliderView];
    
    self.scrollView.delegate = self;
    
    
    // 2.取消 autoresizing
    for (UIView *subview in self.subviews) {
        subview.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // 3.自动布局
    NSDictionary *viewDit = @{@"scrollView": self.scrollView,
                              @"bottomLineViw": self.bottomLineViw};
    // 1> collectionView
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|"
                          options:0
                          metrics:nil
                          views:viewDit]];
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:|-0-[scrollView]-0.5-|"
                          options:0
                          metrics:nil
                          views:viewDit]];
    
    // 2> 底部的细线
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:|-0-[bottomLineViw]-0-|"
                          options:0
                          metrics:nil
                          views:viewDit]];
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:[bottomLineViw(0.5)]-0-|"
                          options:0
                          metrics:nil
                          views:viewDit]];
}

#pragma mark 对外暴露的方法
- (void)setTitleWithProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex {
    //1.取出sourceLabel/targetLabel
    UILabel *sourceLabel = self.titleLabels[sourceIndex];
    UILabel *targetLabel = self.titleLabels[targetIndex];
    
    //2.处理滑块的逻辑
    CGFloat moveTotalX = targetLabel.cs_x - sourceLabel.cs_x;
    CGFloat moveX = moveTotalX * progress;
    self.sliderView.cs_x = sourceLabel.cs_x + moveX;
    self.sliderView.cs_width = sourceLabel.cs_width - (sourceLabel.cs_width - targetLabel.cs_width) * progress;
       
    //3.颜色的渐变(复杂)
    //3.1取出颜色变化的范围
    NSArray<NSNumber *> *normalRGB = [NSArray arrayToRGBWithColor:self.normalColor];
    NSArray<NSNumber *> *selectRGB = [NSArray arrayToRGBWithColor:self.selectColor];
    CGFloat colorDelta[3] = {selectRGB[0].floatValue - normalRGB[0].floatValue,
                             selectRGB[1].floatValue - normalRGB[1].floatValue,
                             selectRGB[2].floatValue - normalRGB[2].floatValue};
    //3.2变化sourceLabel.textColor
    sourceLabel.textColor = FBRGBColor(selectRGB[0].floatValue - colorDelta[0] * progress,
                                       selectRGB[1].floatValue - colorDelta[1] * progress,
                                       selectRGB[2].floatValue - colorDelta[2] * progress);
    //3.2变化targetLabel.textColor
    targetLabel.textColor = FBRGBColor(normalRGB[0].floatValue + colorDelta[0] * progress,
                                       normalRGB[1].floatValue + colorDelta[1] * progress,
                                       normalRGB[2].floatValue + colorDelta[2] * progress);
    
    // 2. 设置滚动内容视图的偏移量
    [self offsetScrollContentWithIndex:targetIndex progress:progress animated:NO];

    //4.记录最新的index
    _selectItem = targetLabel.tag;
}

#pragma mark 设置滚动内容视图的偏移量
/// 设置滚动内容视图的偏移量
/// @param index 滚动到的 label 的 tag
- (void)offsetScrollContentWithIndex:(NSInteger)index progress:(CGFloat)progress animated:(BOOL)animated {
    // 滑块的中心点
    CGFloat sliderCenter = self.titleLabels[index].cs_maxX - self.titleLabels[index].cs_width / 2;
    // self 的中心点
    CGFloat center = self.cs_width / 2;
    
    // 如果滑块的中心点大于self宽度的中心点，改变collectionView滚动视图的偏移量
    if (sliderCenter >= center) {
        
        CGFloat offsetX = sliderCenter - center;
        
        // 最大可偏移量
        CGFloat maxOffsetX = self.scrollView.contentSize.width - self.cs_width;
        if (offsetX >= maxOffsetX) {
            offsetX = maxOffsetX;
        }
        
        // 是否动画
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                self.scrollView.contentOffset = CGPointMake(self->_scrollOffsetX + (offsetX - self->_scrollOffsetX) * progress, 0);
            }];
            _scrollOffsetX = self.scrollView.contentOffset.x;
            
        }else {
                        
            CGFloat moveTotalX = offsetX - _scrollOffsetX;
            _contentOffsetMoveX = moveTotalX * progress;
            
            // 1.scrollView 内容视图时时滚动的方式
            [self.scrollView setContentOffset:CGPointMake(_scrollOffsetX + _contentOffsetMoveX, 0) animated:NO];
            
            // 这里用0.9判断是防止用户快速拖拽的时候获取不到准确的值
            if (progress >= 0.9) {
                // 2。停止滑动内容视图时再滚动 scrollView 内容视图方式
                // [self.scrollView setContentOffset:CGPointMake(_scrollOffsetX + _contentOffsetMoveX, 0) animated:YES];
                _scrollOffsetX = self.scrollView.contentOffset.x;
            }
        }
        
    }else {
        if (animated) {
            [UIView animateWithDuration:0.3 animations:^{
                // 如果 scrollView 内容视图是时时滚动的方式, animated 设置为NO，否则 YES
                [self.scrollView setContentOffset:CGPointMake(self->_scrollOffsetX - self->_scrollOffsetX * progress, 0) animated:NO];
            }];
        }else {
            [self.scrollView setContentOffset:CGPointMake(self->_scrollOffsetX - self->_scrollOffsetX * progress, 0) animated:NO];
        }
        
        if (progress >= 0.9) {
            _scrollOffsetX = self.scrollView.contentOffset.x;
        }
        
    }
    
}

#pragma mark 懒加载
- (NSMutableArray<UILabel *> *)titleLabels {
    if (!_titleLabels) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (UIView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[UIView alloc] init];
    }
    return _sliderView;
}

- (UIView *)bottomLineViw {
    if (!_bottomLineViw) {
        _bottomLineViw = [[UIView alloc] init];
    }
    return _bottomLineViw;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.bounces = YES;
        _scrollView.scrollEnabled  = YES;
    }
    return _scrollView;
}

#pragma mark cellID
static NSString *const cellID = @"FBTitleCollectionCell";
@end
