//
//  BaseNavigationController.m
//  simfieldV1.6_iOS
//
//  Created by admin on 17/7/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_all-64"] forBarMetrics:UIBarMetricsDefault];
    NSDictionary *dic = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:20],
                          NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationBar.titleTextAttributes = dic;
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
