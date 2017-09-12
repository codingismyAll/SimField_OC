//
//  EnumCell.h
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSOPickerView.h"

@interface EnumCell : UITableViewCell

@property(nonatomic,strong) UILabel *label;

@property(nonatomic,strong) UITextField *textField;

@property(nonatomic,strong) YLSOPickerView *pickerView;

@end
