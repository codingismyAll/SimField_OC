//
//  PointCell.m
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PointCell.h"

@implementation PointCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}


- (void)setPointModel:(PointModel *)pointModel{
    
    _pointModel = pointModel;
    self.pointNameLabel.text = _pointModel.name;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
