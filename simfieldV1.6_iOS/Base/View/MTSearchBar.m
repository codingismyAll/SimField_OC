//
//  MTSearchBar.m
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/30.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MTSearchBar.h"

@implementation MTSearchBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.frame.size = CGSizeMake(300, 30);
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入查询条件";
        // 提前在Xcode上设置图片中间拉伸
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        // 通过init初始化的控件大多都没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        // contentMode：default is UIViewContentModeScaleToFill，要设置为UIViewContentModeCenter：使图片居中，防止图片填充整个imageView
        searchIcon.contentMode = UIViewContentModeCenter;
//        searchIcon.size = CGSizeMake(30, 30);
        
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    CGRect iconRect = [super leftViewRectForBounds:bounds];
    iconRect.origin.x += 16; //像右边偏15
    return iconRect;
}


//UITextField 文字与输入框的距离
- (CGRect)textRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 45, 0);
    
}

//控制文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds{
    
    return CGRectInset(bounds, 45, 0);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
