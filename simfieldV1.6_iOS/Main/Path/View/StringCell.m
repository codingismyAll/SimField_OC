//
//  StringCell.m
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "StringCell.h"

@implementation StringCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.label = [[UILabel alloc] init];
        self.label.numberOfLines = 2;
        [self.contentView addSubview:self.label];
        self.textField = [[UITextField alloc]init];
        [self.contentView addSubview:self.textField];
    }
    return self;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = CGRectMake(20, 0, 100, self.contentView.frame.size.height);
    self.textField.frame = CGRectMake(self.label.frame.size.width + 25, 0, self.contentView.frame.size.width - 100, self.contentView.frame.size.height);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
