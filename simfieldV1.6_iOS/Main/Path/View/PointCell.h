//
//  PointCell.h
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointModel.h"

@interface PointCell : UITableViewCell

@property (nonatomic, strong) PointModel *pointModel;

@property (weak, nonatomic) IBOutlet UIImageView *pointOrder;
@property (weak, nonatomic) IBOutlet UILabel *pointNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *signButton;
@property (weak, nonatomic) IBOutlet UIButton *itemButton;
@property (weak, nonatomic) IBOutlet UIButton *mapButton;

@end 
