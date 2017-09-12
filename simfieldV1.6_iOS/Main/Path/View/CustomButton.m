//
//  CustomButton.m
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/22.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton


- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName title:(NSString *)title{
    
    if (self = [super initWithFrame:frame]) {
       
        self.imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
        
        self.imgView.frame = CGRectMake(0, 0, frame.size.width/3, frame.size.height);
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width/3 + 5, 0, frame.size.width*2/3-5, frame.size.height)];
        self.label.textColor = [UIColor whiteColor];
        self.label.font = [UIFont systemFontOfSize:20];
        self.label.text = title;
        
        [self addSubview:self.label];
        [self addSubview:self.imgView];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
