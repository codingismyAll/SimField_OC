//
//  DFTabBarButton.h
//  老子第一个项目 一定要做完
//
//  Created by admin on 16/6/2.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DFTabBarButton : UIButton
{
    UIImageView *imgView;
    UILabel *label;
}

- (instancetype)initWithFrame:(CGRect)frame
                withImageName:(NSString *)imageName
                    withTitle:(NSString *)title;
@end
