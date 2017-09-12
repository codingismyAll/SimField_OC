//
//  PathViewCell.m
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/3.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PathViewCell.h"

@implementation PathViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
//- (void)setTaskModel:(TaskModel *)taskModel{
//    _taskModel = taskModel;
//    self.taskName.text = _taskModel.name;
////    self.pathName.text = _taskModel.pathModel.name;
//
//}

- (void)setPathModel:(PathModel *)pathModel{
    _pathModel = pathModel;
    self.taskName.text = _pathModel.taskModel.name;
    self.pathName.text = _pathModel.name;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
