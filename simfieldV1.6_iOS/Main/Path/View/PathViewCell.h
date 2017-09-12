//
//  PathViewCell.h
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/3.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskModel.h"
#import "PathModel.h"

@interface PathViewCell : UITableViewCell

@property (nonatomic, strong) TaskModel *taskModel;
@property (nonatomic, strong) PathModel *pathModel;


@property (weak, nonatomic) IBOutlet UILabel *pathName;
@property (weak, nonatomic) IBOutlet UILabel *taskName;
@property (weak, nonatomic) IBOutlet UIImageView *stateImg;

@end
