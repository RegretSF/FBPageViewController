//
//  FBPageContentView.m
//  PageView
//
//  Created by tq001 on 2019/9/29.
//  Copyright © 2019 Fat brther. All rights reserved.
//

#import "FBPageContentView.h"
#import "UIColor+FBExtension.h"
#import "UIView+FBExtension.h"

@interface FBPageContentView () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collectionView;
@end

@implementation FBPageContentView {
    /// 是否禁止滚动
    BOOL _isForbidScrollDelegate;
    /// 开始滚动X偏移量
    CGFloat _startOffsetX;
    /// 记录滚动到哪一个界面
    NSInteger _currentIndex;
    /// 滚动的时候原索引
    NSInteger _sourceIndex;
    /// 滚动的时候目标索引
    NSInteger _targetIndex;
    
}
#pragma mark 初始化
- (instancetype)initWithFrame:(CGRect)frame
         parentViewController:(UIViewController *)parentViewController
                     childVCs:(NSArray<UIViewController *> *)childVCs {
    self = [super initWithFrame:frame];
    if (self) {
        self.childVCs = childVCs;
        self.parentViewController = parentViewController;
        _isForbidScrollDelegate = NO;
        [self setupUI];
    }
    return self;
}

#pragma mark setter
- (void)setChildVCs:(NSArray<UIViewController *> *)childVCs {
    _childVCs = childVCs;
    [self.collectionView reloadData];
}

#pragma mark 设置UI界面
- (void)setupUI {
    _sourceIndex = 0;
    _targetIndex = 0;
    
    //0.将所有的子控制器添加到父类控制器中
    for (UIViewController *childVC in self.childVCs) {
        [self.parentViewController addChildViewController:childVC];
    }
    
    // 1.添加控件
    [self addSubview:self.collectionView];
    
    // 注册cell
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
    
    // 2.取消 autoresizing
    for (UIView *subview in self.subviews) {
        subview.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    // 3.自动布局
    NSDictionary *viewDit = @{@"collectionView": self.collectionView};
    // 1> collectionView
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"H:|-0-[collectionView]-0-|"
                          options:0
                          metrics:nil
                          views:viewDit]];
    [self addConstraints:[NSLayoutConstraint
                          constraintsWithVisualFormat:@"V:|-0-[collectionView]-0-|"
                          options:0
                          metrics:nil
                          views:viewDit]];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.childVCs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 1.创建cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    //2.给cell设置内容
    //防止多次添加 childVC.view ，所以在添加childVC.view之前先把之前缓存的视图给移除
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    UIViewController *childVC = self.childVCs[indexPath.item];
    childVC.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:childVC.view];
    
    return cell;
}

#pragma mark UICollectionViewDelegate
/// 开始滑动时
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isForbidScrollDelegate = NO;
    
    _startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 停止类型1、停止类型2
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        //2.判断左滑还是右滑
        CGFloat currentOffsetX = scrollView.contentOffset.x;
        if (currentOffsetX > _startOffsetX) {    //左滑
            /// 防止用户过快的滑动时 _targetIndex 的值 和 _sourceIndex的值不准确，但有时候还是不准确，很难测出效果
            _targetIndex = _sourceIndex;
            _sourceIndex = _targetIndex;
            if ([self.delegate respondsToSelector:@selector(pageContentView:progress:sourceIndex:targetIndex:)]) {
                [self.delegate pageContentView:self progress:1 sourceIndex:_sourceIndex targetIndex:_targetIndex];
            }
        }

    }
}

/// 监听滚动的变化
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        //0.判断是否是点击事件
    if (_isForbidScrollDelegate == YES) { return; }
    
    //1.获取需要的数据
    CGFloat progress = 0;
    
    //2.判断左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.cs_width;
    if (currentOffsetX > _startOffsetX) {    //左滑
        //1.计算progress,floor是取整的意思
        CGFloat ratio = currentOffsetX / scrollViewW;
        progress = ratio - floor(ratio);
        
        //2.计算sourceIndex
        _sourceIndex = ratio;
        
        //3.计算targetIndex
        _targetIndex = _sourceIndex + 1;
        if (_targetIndex >= self.childVCs.count) {
            _targetIndex = self.childVCs.count - 1;
            progress = 1;
        }
        
        //4.如果完全滑过去
        if ((currentOffsetX - _startOffsetX) == scrollViewW) {
            progress = 1;
            _targetIndex = _sourceIndex;
        }
        
    }else {                                 //右滑
        //1.计算progress
        CGFloat ratio = currentOffsetX / scrollViewW;
        progress = 1 - (ratio - floor(ratio));
        
        //2.计算targetIndex
        _targetIndex = (NSInteger)ratio;
        
        //3.计算sourceIndex
        _sourceIndex = _targetIndex + 1;
        if (_sourceIndex >= self.childVCs.count) {
            _sourceIndex = self.childVCs.count - 1;
        }
    }

    //3.将progress/targetIndex/sourceIndex传递给titleView
    if ([self.delegate respondsToSelector:@selector(pageContentView:progress:sourceIndex:targetIndex:)]) {
        [self.delegate pageContentView:self progress:progress sourceIndex:_sourceIndex targetIndex:_targetIndex];
    }
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.cs_width, self.collectionView.cs_height);
}

#pragma mark 对外暴露的方法
- (void)setCurrentIndex:(NSInteger)index {
    //1.记录需要禁止执行的代理方法
    _isForbidScrollDelegate = YES;
    
    //2、滚动到正确的位置
    CGFloat w = self.collectionView.frame.size.width;
    CGFloat offsetX = index * w;
    
    CATransitionType type;
    if (index > _currentIndex) {
        type = kCATransitionFromRight;
    }else {
        type = kCATransitionFromLeft;
    }
    
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0)];
    
    // 3.设置滚动时的动画
    [self transitionWithType:kCATransitionPush WithSubtype:type ForView:self.collectionView];
    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
    
    // 4.设置 self 的背景颜色，防止执行动画时闪白屏.
    UIViewController *currentVC = self.childVCs[index];
    self.backgroundColor = currentVC.view.backgroundColor;
    
    // 5.记录当前滚动的页面
    _currentIndex = index;
}

#pragma CATransition动画实现
/**
 * 动画效果实现
 *
 * @param type  动画的类型 在开头的枚举中有列举,比如 CurlDown//下翻页,CurlUp//上翻页
 ,FlipFromLeft//左翻转,FlipFromRight//右翻转 等...
 * @param subtype 动画执行的起始位置,上下左右
 * @param view  哪个view执行的动画
 */
- (void)transitionWithType:(NSString *)type WithSubtype:(NSString *)subtype ForView:(UIView *)view {
    
    //创建CATransition对象
    CATransition *animation = [CATransition animation];
    //设置时间
    animation.duration = 0.3;
    //设置类型
    animation.type = type;
    //设置方向
    animation.subtype = subtype;
    //设置运动速度变化
    CAMediaTimingFunction *a = [CAMediaTimingFunction functionWithControlPoints:0.7 :0.5 :0.3 :0.1];
    animation.timingFunction = a;
    
    [view.layer addAnimation:animation forKey:@"animation"];

}

#pragma mark 懒加载
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0.0;
        layout.minimumLineSpacing = 0.0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
    }
    return _collectionView;
}

#pragma mark cellID
static NSString *const cellID = @"cellID";
@end
