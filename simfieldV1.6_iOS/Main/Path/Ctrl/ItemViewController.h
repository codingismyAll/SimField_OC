//
//  ItemViewController.h
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "BaseViewController.h"
#import "THDatePickerView.h"
#import "YLSOPickerView.h"

@interface ItemViewController : BaseViewController

@property (nonatomic, strong) NSArray *checkItem;

@property (strong, nonatomic) THDatePickerView *dateView;

@property (strong, nonatomic) UIButton *btn;

@property(nonatomic,strong) YLSOPickerView *pickerView;

@end
