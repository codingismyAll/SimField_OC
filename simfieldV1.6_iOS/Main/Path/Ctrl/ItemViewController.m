//
//  ItemViewController.m
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "ItemViewController.h"
#import "ItemModel.h"
#import "NumberCell.h"
#import "CustomButton.h"
#import "EnumCell.h"
#import "TimeCell.h"
#import "StringCell.h"

@interface ItemViewController ()<UITableViewDelegate,UITableViewDataSource,NumberCellDelegate,THDatePickerViewDelegate,UITextFieldDelegate>
{
    UITableView *_table;
    
    NSMutableArray *_dataArray;
    
}

@property(nonatomic,strong) TimeCell *dateCell;

/** array */
@property (nonatomic,strong) NSArray *arrayData;

@end

@implementation ItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"self.checkItem = %@", self.checkItem);
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self createButtonView];

    [self _parseJsonData];
    
    [self createTableView];
    
}
#pragma mark - 创建表视图

- (void)createButtonView{
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 60)];
    buttonView.backgroundColor = [UIColor blueColor];
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth/2, 5, 1, 50)];
    whiteView.backgroundColor = [UIColor whiteColor];
    
    CustomButton *saveButton = [[CustomButton alloc] initWithFrame:CGRectMake(kScreenWidth/4-35, 15, 70, 25) imageName:@"btn_save" title:@"保存"];
    
    CustomButton *commitButton = [[CustomButton alloc] initWithFrame:CGRectMake(kScreenWidth*3/4 - 35, 15, 70, 25) imageName:@"btn_done" title:@"提交"];
    
    [buttonView addSubview:whiteView];
    [buttonView addSubview:saveButton];
    [buttonView addSubview:commitButton];
    [self.view addSubview:buttonView];
}


- (void)createTableView {
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 124, kScreenWidth, kScreenHeight - 64 - 60) style:UITableViewStylePlain];
    _table.dataSource = self;
    _table.delegate = self;
    _table.backgroundColor = [UIColor clearColor];
//    _table.separatorStyle = UITableViewCellEditingStyleNone;

    _table.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

    [self.view addSubview:_table];
    
}

//解析数据
- (void)_parseJsonData{
    
    _dataArray = [[NSMutableArray alloc] init];
    for (NSDictionary *pointDic in self.checkItem) {
        ItemModel *itemModel = [[ItemModel alloc] init];
        itemModel.allowSkip = pointDic[@"allowSkip"];
        itemModel.code = pointDic[@"code"];
        itemModel.name = pointDic[@"name"];
        itemModel.stdDate = pointDic[@"stdDate"];
        itemModel.stdEnum = pointDic[@"stdEnum"];
        itemModel.stdValue = pointDic[@"stdValue"];
        itemModel.type = pointDic[@"type"];
        [_dataArray addObject:itemModel];
    }
    
    [_table reloadData];
    
    
}

#pragma - mark tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ItemModel *itModel = [[ItemModel alloc] init];
    itModel = [_dataArray objectAtIndex:indexPath.row];
    
    if ([itModel.type isEqualToString:@"数值型"]) {
       
        NumberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell1"];
        if (!cell) {
            cell = [[NumberCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell1"];
        }
        cell.label.text = itModel.name;
        return cell;
        
    }else if ([itModel.type isEqualToString:@"枚举型"]) {
        EnumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2"];
        if (!cell) {
            cell = [[EnumCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell2"];
        }
        cell.textField.delegate = self;

        cell.textField.tag = indexPath.row + 100;
        cell.label.text = itModel.name;
        return cell;
        
    }else if ([itModel.type isEqualToString:@"时间型"]){
        TimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell3"];
        if (!cell) {
            cell = [[TimeCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell3"];
        }
        cell.label.text = itModel.name;
        
        self.btn = [[UIButton alloc] initWithFrame:self.view.bounds];
        self.btn.backgroundColor = [UIColor blackColor];
        self.btn.hidden = YES;
        self.btn.alpha = 0.3;
        [self.view addSubview:self.btn];
        
        //@property类型  weak和strong
        self.dateView = [[THDatePickerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300)];
        self.dateView.delegate = self;
        self.dateView.title = @"请选择时间";
        [self.view addSubview:self.dateView];
        [cell.setDate addTarget:self action:@selector(showDateView:) forControlEvents:UIControlEventTouchUpInside];
        
        self.dateCell = cell;
        
        return cell;
        
    }
    else if ([itModel.type isEqualToString:@"字符型"]){
        StringCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell4"];
        if (!cell) {
            cell = [[StringCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell4"];
        }
        
        
        cell.label.text = itModel.name;
        return cell;
        
    }
    else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell5"];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell5"];
        }
        return cell;
    }

}

//时间的选择控件
- (void)showDateView:(UIButton *)button{
  
    self.btn.hidden = NO;
    
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300);
        [self.dateView show];
        
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    ItemModel *itModel = [[ItemModel alloc] init];
    itModel = [_dataArray objectAtIndex:textField.tag-100];
    
    self.pickerView = [[YLSOPickerView alloc]init];
    if (itModel.stdEnum) {
        
    }
    NSString *dataStr = itModel.stdEnum[@"standardEnumAllValues"][@"value"];
    

    self.pickerView.array = [dataStr componentsSeparatedByString:@","];
    self.pickerView.title = itModel.name;
    [self.pickerView show];
    
    return NO;
}


#pragma mark - THDatePickerViewDelegate
/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerViewSaveBtnClickDelegate:(NSString *)timer {
    NSLog(@"保存点击");
    
    [self.dateCell.setDate setTitle:timer forState:UIControlStateNormal];
    
    [self.dateCell.setDate setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    self.btn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
}

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate {
    NSLog(@"取消点击");
    self.btn.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.dateView.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 300);
    }];
}
//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)textDidChange:(NSInteger)length {
    
}

-(void)dealloc
{
    
    //移除观察者，Observer不能为nil
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
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
