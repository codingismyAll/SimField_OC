//
//  HiddenViewController.m
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/1.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "HiddenViewController.h"

@interface HiddenViewController ()

@end

@implementation HiddenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"隐患列表";
   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)back{
    
    
    UITabBarController * tabbarCtl = self.tabBarController;
    UINavigationController * nav = tabbarCtl.navigationController;
    [nav popViewControllerAnimated:YES];
    
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
