//
//  DFTabBarButton.m
//  老子第一个项目 一定要做完
//
//  Created by admin on 16/6/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "DFTabBarButton.h"
#define kItemSize 25
@implementation DFTabBarButton

- (instancetype)initWithFrame:(CGRect)frame withImageName:(NSString *)imageName withTitle:(NSString *)title
{
    if (self = [super initWithFrame:frame]) {
        
        imgView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - kItemSize) / 2, 5, kItemSize, kItemSize)];
        imgView.image = [UIImage imageNamed:imageName];
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imgView];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imgView.frame) + 5, frame.size.width, 10)];
        
        label.text = title;
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
//        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
        
    
    }
    return self;
}

@end
