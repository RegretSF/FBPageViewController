# FBPageViewController
用法：
1.继承自 FBPageViewController，传相对应的数据，设置对应的属性即可。（建议）
  如：
  .h
  #import "FBPageViewController.h"
  NS_ASSUME_NONNULL_BEGIN
  @interface DTPageViewController : FBPageViewController
  @end
  
  .m
  #import "DTPageViewController.h"
  #import "UIColor+FBExtension.h"
  @implementation DTPageViewController
  - (void)viewDidLoad {
      [super viewDidLoad];

      // 设置颜色
  //    self.normalColor = [UIColor colorWithR:85 g:85 b:85];
  //    self.selectColor = [UIColor colorWithR:255 g:128 b:85];
  //    self.sliderColor = [UIColor colorWithR:255 g:128 b:85];

      self.normalColor = UIColor.randomColor;
      self.selectColor = UIColor.randomColor;
      self.sliderColor = UIColor.randomColor;
      // 设置标题视图的高度
      self.pageTitleViewHeight = 44;

      /// 设置数据源
      self.titleFontSize = 14;
      self.titles = @[@"大萨达", @"广告费", @"热点", @"新", @"最新", @"体育", @"明星", @"同城", @"军事", @"历史", @"时尚", @"离开"];
      NSMutableArray *childVCs = [NSMutableArray array];
      for (int i = 0; i < self.titles.count; i++) {
          UIViewController *vc = [[UIViewController alloc] init];
          vc.view.backgroundColor = UIColor.randomColor;
          [childVCs addObject:vc];
      }
      self.childVCs = childVCs;

      //模拟‘延时’加载数据 -> dispatch_after
  //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
  //        /// 设置数据源
  //        self.titleFontSize = 14;
  //        self.titles = @[@"大萨达", @"广告费", @"热点", @"新", @"最新", @"体育", @"明星", @"同城", @"军事", @"历史", @"时尚", @"离开"];
  //        NSMutableArray *childVCs = [NSMutableArray array];
  //        for (int i = 0; i < self.titles.count; i++) {
  //            UIViewController *vc = [[UIViewController alloc] init];
  //            vc.view.backgroundColor = UIColor.randomColor;
  //            [childVCs addObject:vc];
  //        }
  //        self.childVCs = childVCs;
  //    });
  }
  
2.直接在 FBPageViewController 里操作

3.使用的时候记得把分类也添加进去
