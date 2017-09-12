//
//  RootTabBarController.m
//  simfieldV1.6_iOS
//
//  Created by admin on 17/7/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "RootTabBarController.h"
#import "DFTabBarButton.h"

@interface RootTabBarController ()
{
    UIImageView *_selectImageView;
    UILabel *label;
    CGFloat itemWidth;
    
}
@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _createViewControllers];
    [self.tabBar setBackgroundColor:[UIColor blackColor]];
    
    [self _createTabBar];
}


- (void)_createViewControllers
{
    NSArray *nameArr = @[@"Path", @"HiddenRisk", @"Statistic"];
    NSMutableArray *ViewControllers = [NSMutableArray array];
    
    for (NSString *str in nameArr) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:str bundle:nil];
        
        UIViewController *vc = [sb instantiateInitialViewController];
        
        [ViewControllers addObject:vc];
    }
    self.viewControllers = ViewControllers;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    for (UIView *view in self.tabBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [view removeFromSuperview];
            
        }
    }
}

- (void)_createTabBar
{
    
    itemWidth = [UIScreen mainScreen].bounds.size.width / 3;
    
    
    NSArray *nameArr = @[@"巡检线路", @"隐患列表", @"查询统计"];
    NSArray *imgArr = @[@"menu_xjxl_p", @"menu_xw_p", @"menu_cxtj_p"];
    for (int i = 0; i < 3; i++) {
        DFTabBarButton *button = [[DFTabBarButton alloc]initWithFrame:CGRectMake(itemWidth * i, 0, itemWidth, 49) withImageName:imgArr[i] withTitle:nameArr[i]];
        
        [button addTarget:self action:@selector(buttonAction:) forControlEvents: UIControlEventTouchUpInside];
        button.tag = 100 + i;
        [self.tabBar addSubview:button];
        
        
    }
    
    _selectImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4"]];
    _selectImageView.frame = CGRectMake((itemWidth - 25) / 2, 5, 25, 25);
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, itemWidth, 10)];
    label.text = @"巡检线路";
    label.textColor = [UIColor redColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:14];
    [self.tabBar addSubview:label];
    [self.tabBar addSubview:_selectImageView];
    
}

- (void)buttonAction:(UIButton *)sender
{
    
    self.selectedIndex = sender.tag - 100;
    
    if (sender.tag == 100) {
        _selectImageView.image = [UIImage imageNamed:@"4"];
        _selectImageView.frame = CGRectMake((itemWidth - 25) / 2, 5, 25, 25);
        label.frame = CGRectMake(0, 35, itemWidth, 10);
        label.text = @"巡检线路";
        
    }else if (sender.tag == 101){
        
        _selectImageView.image = [UIImage imageNamed:@"5"];
        _selectImageView.frame = CGRectMake(itemWidth + (itemWidth - 25) / 2, 5, 25, 25);
        label.frame = CGRectMake(itemWidth, 35, itemWidth, 10);
        label.text = @"隐患列表";
        
    }else{
        _selectImageView.image = [UIImage imageNamed:@"7"];
        _selectImageView.frame = CGRectMake(2 * itemWidth + (itemWidth - 25) / 2, 5, 25, 25);
        label.frame = CGRectMake(2 * itemWidth, 35, itemWidth, 10);
        label.text = @"查询统计";
        
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
