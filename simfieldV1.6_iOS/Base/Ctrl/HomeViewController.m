//
//  HomeViewController.m
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/7/30.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "RootTabBarController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *flowImage;
@property (weak, nonatomic) IBOutlet UIImageView *supImage;
@property (weak, nonatomic) IBOutlet UIImageView *insImage;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg.png"]]];
    UITapGestureRecognizer *myTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClicked:)];
    _flowImage.userInteractionEnabled = YES;
    [_flowImage addGestureRecognizer:myTapGesture];
    
//    _supImage.userInteractionEnabled = YES;
//    [_supImage addGestureRecognizer:myTapGesture];
//
//    _insImage.userInteractionEnabled = YES;
//    [_insImage addGestureRecognizer:myTapGesture];
}



-(void)imageViewClicked:(UITapGestureRecognizer*)gestRecognizer
{
    RootTabBarController *root = [[RootTabBarController alloc] init];
    [self.navigationController pushViewController:root animated:YES];
}
- (IBAction)logout:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
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
