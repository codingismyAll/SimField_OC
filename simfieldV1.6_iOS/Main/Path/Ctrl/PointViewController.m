//
//  PointViewController.m
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PointViewController.h"
#import "PointModel.h"
#import "PointCell.h"
#import "ItemViewController.h"

@interface PointViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_table;
    
    NSMutableArray *_dataArray;
    
    NSMutableArray *_signIn;
    
}
@end

@implementation PointViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"self.checkPoint = %@", self.checkPoint);
    
    
    
    [self createTableView];
    [self _parseJsonData];

}

#pragma mark - 创建表视图
- (void)createTableView {
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _table.dataSource = self;
    _table.delegate = self;
    _table.backgroundColor = [UIColor clearColor];
    
    _table.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

    [self.view addSubview:_table];
    
    
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"PointCell" bundle:[NSBundle mainBundle]];
    [_table registerNib:nib forCellReuseIdentifier:@"PointCellID"];
    
    
}

//解析数据
- (void)_parseJsonData{
    
    _dataArray = [[NSMutableArray alloc] init];
    _signIn = [[NSMutableArray alloc] init];
    for (NSDictionary *pointDic in self.checkPoint) {
        PointModel *pointModel = [[PointModel alloc] init];
        pointModel.name = pointDic[@"name"];
        pointModel.checkItem = pointDic[@"checkItem"];
        [_dataArray addObject:pointModel];
        [_signIn addObject:@(NO)];
    }
    
    [_table reloadData];
    
    
}
#pragma - mark tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PointCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PointCellID" forIndexPath:indexPath];
    
    [cell.signButton addTarget:self action:@selector(sign:) forControlEvents:UIControlEventTouchUpInside];
    cell.signButton.tag = 200 + indexPath.row;
    [cell.itemButton addTarget:self action:@selector(goItem:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.itemButton.tag = 100 + indexPath.row;
    cell.pointModel = _dataArray[indexPath.row];
    
    return cell;
    
}


- (void)sign:(UIButton *)btn{
//    UITableViewCell *cell = [self tableView:_table cellForRowAtIndexPath:btn.tag-200];
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"签到方式" message:@"请选择签到方式" preferredStyle: UIAlertControllerStyleActionSheet];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *codeSign = [UIAlertAction actionWithTitle:@"二维码签到" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"调用二维码签到方式");
    }];
    
    
    UIAlertAction *GPSSign = [UIAlertAction actionWithTitle:@"GPS签到" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"调用GPS签到");
    }];
    
    UIAlertAction *handSign = [UIAlertAction actionWithTitle:@"手动签到" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        NSLog(@"调用手动签到");
       
        UIAlertController *signAlertController = [UIAlertController alertControllerWithTitle:@"手动签到" message:@"在其他签到方式无效的情况下，可手动签到并填写原因" preferredStyle: UIAlertControllerStyleAlert];
       
        [signAlertController addAction:[UIAlertAction actionWithTitle:@"确定"style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            NSLog(@"点击了确定按钮");
            
            PointCell *cell =(PointCell *) btn.superview.superview;
            cell.signButton.hidden = YES;
            [_signIn replaceObjectAtIndex:btn.tag-200 withObject:@(YES)];
        }]];
        
        [signAlertController addAction:[UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"点击了取消按钮");
        }]];
        
        [signAlertController addTextFieldWithConfigurationHandler:^(UITextField*textField) {
            textField.textColor= [UIColor blackColor];
            
//            [textField addTarget:self action:@selector(usernameDidChange:)forControlEvents:UIControlEventEditingChanged];
            
        }];
        
        [self presentViewController:signAlertController animated:YES completion:nil];
        
     
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:codeSign];
    [alertController addAction:GPSSign];
    [alertController addAction:handSign];

    [self presentViewController:alertController animated:YES completion:nil];


}

- (void)goItem:(UIButton *)btn{
    
    if(![[_signIn objectAtIndex:btn.tag - 100] boolValue]){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先签到！" preferredStyle:UIAlertControllerStyleAlert];
        

        
        [self presentViewController:alert animated:NO completion:nil];

        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(creatAlert:) userInfo:alert repeats:NO];
        
        return;
    }
    
    PointModel *pointModel = [[PointModel alloc] init];
    
    pointModel = _dataArray[btn.tag - 100];
    ItemViewController *itemVC = [[ItemViewController alloc] init];
    itemVC.checkItem = pointModel.checkItem;
    [self.navigationController pushViewController:itemVC animated:YES];
}


- (void)creatAlert:(NSTimer *)timer{
    
    UIAlertController *alert = [timer userInfo];
    [alert dismissViewControllerAnimated:YES completion:nil];
    alert = nil;
}
//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
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
