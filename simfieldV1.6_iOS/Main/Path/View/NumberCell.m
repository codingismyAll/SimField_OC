//
//  NumberCell.m
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/17.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "NumberCell.h"

@implementation NumberCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.label = [[UILabel alloc] init];
        self.label.numberOfLines = 2;
        [self.contentView addSubview:self.label];
        self.textField = [[UITextField alloc]init];
        self.textField.delegate = self;
        self.textField.placeholder = @"数值型";
        self.textField.keyboardType = UIKeyboardTypeNumberPad;
        [self.contentView addSubview:self.textField];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:nil];
   
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textDidChange {
    if (self.delegate && [self.delegate respondsToSelector:@selector(textDidChange:)]) {
        [self.delegate textDidChange:self.textField.text.length];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = CGRectMake(20, 0, 100, self.contentView.frame.size.height);
    self.textField.frame = CGRectMake(self.label.frame.size.width + 25, 0, self.contentView.frame.size.width - 100, self.contentView.frame.size.height);
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

@end
