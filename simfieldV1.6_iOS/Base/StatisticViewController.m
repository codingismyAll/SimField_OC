//
//  StatisticViewController.m
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/1.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "StatisticViewController.h"
#import<QuartzCore/QuartzCore.h>
#import "MTSearchBar.h"

@interface StatisticViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *proTimeList;

@property (nonatomic, strong) UITextField *pickerViewTextField;

@property (nonatomic, strong) UIButton *selectButton;

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSString *proTimeStr;

@end


@implementation StatisticViewController

@synthesize pickerViewTextField = _pickerViewTextField;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationItem.title = @"查询统计";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.view.backgroundColor = [UIColor blueColor];

    self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectButton.frame = CGRectMake(10, 74, 100, 40);
    [self.selectButton setTitle:@"巡检查询" forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageNamed:@"icon_zk"] forState:UIControlStateNormal];

    [self.selectButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.selectButton.currentImage.size.width-20, 0, 0)];

    [self.selectButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -self.selectButton.titleLabel.intrinsicContentSize.width-75)];
    
    [self.selectButton addTarget:self action:@selector(selectType:) forControlEvents:UIControlEventTouchUpInside];
//    self.selectButton.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.selectButton];
    
    _proTimeList = [[NSArray alloc]initWithObjects:@"巡检查询",@"隐患查询",nil];

    
    
    // set the frame to zero
    self.pickerViewTextField = [[UITextField alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.pickerViewTextField];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    // set change the inputView (default is keyboard) to UIPickerView
    //把pickerView赋值给textField的inputView
    self.pickerViewTextField.inputView = self.pickerView;
    
    // add a toolbar with Cancel & Done button
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTouched:)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTouched:)];
    
    // the middle button is to make the Done button align to right
    [toolBar setItems:[NSArray arrayWithObjects:cancelButton, [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil]];
    self.pickerViewTextField.inputAccessoryView = toolBar;
    
    MTSearchBar *searchTextField = [[MTSearchBar alloc] initWithFrame:CGRectMake(130, 74, self.view.frame.size.width - 140, 40)];

    UIColor *color = [UIColor whiteColor];
    searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入查询条件" attributes:@{NSForegroundColorAttributeName: color}];
    searchTextField.layer.borderColor = [[UIColor colorWithRed:215.0 / 255.0 green:215.0 / 255.0 blue:215.0 / 255.0 alpha:1] CGColor];
    searchTextField.layer.borderWidth = 0.5f;
    searchTextField.layer.cornerRadius = 5.0;
    searchTextField.font = [UIFont systemFontOfSize:19];
    
//    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImageView *searchImageView = [[UIImageView alloc] init];
    searchImageView.image = [UIImage imageNamed:@"icon_search"];
    searchImageView.contentMode = UIViewContentModeCenter;
    searchTextField.leftView = searchImageView;
    searchTextField.leftViewMode = UITextFieldViewModeAlways;
    searchTextField.layer.masksToBounds = YES;
    [self.view addSubview:searchTextField];
    
}

- (void)cancelTouched:(UIBarButtonItem *)sender
{
    // hide the picker view
    [self.pickerViewTextField resignFirstResponder];
}

- (void)doneTouched:(UIBarButtonItem *)sender
{
    // hide the picker view
//    self.selectButton setTitle:[self pickerView:self.pickerView titleForRow:<#(NSInteger)#> forComponent:<#(NSInteger)#>] forState:<#(UIControlState)#>
    [self.pickerViewTextField resignFirstResponder];
    
    // perform some action
    if(self.proTimeStr){
        
        [self.selectButton setTitle:self.proTimeStr forState:UIControlStateNormal];
    }
}

- (void)selectType:(id)sender{
    
    [self.pickerViewTextField becomeFirstResponder];
}

- (void)back{
    
    UITabBarController * tabbarCtl = self.tabBarController;
    UINavigationController * nav = tabbarCtl.navigationController;
    [nav popViewControllerAnimated:YES];
    
}


#pragma Mark -- UIPickerViewDataSource
// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    
    return [_proTimeList count];
}

#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    
        return 200;
   
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
        self.proTimeStr = [_proTimeList objectAtIndex:row];
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
        return [_proTimeList objectAtIndex:row];
    
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
