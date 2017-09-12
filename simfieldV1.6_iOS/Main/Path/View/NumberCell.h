//
//  NumberCell.h
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NumberCellDelegate <NSObject>

- (void)textDidChange:(NSInteger)length;

@end

@interface NumberCell : UITableViewCell<UITextFieldDelegate>


@property (nonatomic,strong)UILabel *label;

@property (nonatomic,strong)UITextField *textField;

@property (nonatomic, weak) id<NumberCellDelegate>delegate;

@end
