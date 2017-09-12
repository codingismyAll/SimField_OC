//
//  TimeCell.m
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "TimeCell.h"

@implementation TimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.label = [[UILabel alloc] init];
        self.label.numberOfLines = 2;
        [self.contentView addSubview:self.label];
        
        self.setDate = [[UIButton alloc] init];
        
        // UIDatePicker控件的常用方法  时间选择控件
//        self.datePicker = [[UIDatePicker alloc] init];
//        
//        self.datePicker.date = [NSDate date]; // 设置初始时间
//        // [oneDatePicker setDate:[NSDate dateWithTimeIntervalSinceNow:48 * 20 * 18] animated:YES]; // 设置时间，有动画效果
//        self.datePicker.timeZone = [NSTimeZone timeZoneWithName:@"GTM+8"]; // 设置时区，中国在东八区
//        self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60 * -1]; // 设置最小时间
//        self.datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:72 * 60 * 60]; // 设置最大时间
//        self.datePicker.datePickerMode = UIDatePickerModeDateAndTime; // 设置样式
//        [self.contentView addSubview:self.datePicker];
        
        //使用datePicker第一步，设置datePickerMode,默认状态下是UIDatePickerModeDateAndTime
        //   self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        //第二步，设置其他细节问题，入最早时间，最迟时间等等，目前没有设置，跳骨

        
        [self.contentView addSubview:self.setDate];
        

    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = CGRectMake(20, 0, 100, self.contentView.frame.size.height);
    self.setDate.frame = CGRectMake(self.label.frame.size.width + 25, 0, self.contentView.frame.size.width - 100, self.contentView.frame.size.height);
}











- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
