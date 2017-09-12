//
//  CustomButton.h
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

@property (nonatomic,strong) UILabel *label;

@property (nonatomic,strong) UIImageView *imgView;

- (instancetype)initWithFrame:(CGRect)frame
                    imageName:(NSString *)imageName
                   title:(NSString *)title;

@end
