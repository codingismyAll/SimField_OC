//
//  PathModel.m
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/6.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PathModel.h"
#import "TaskModel.h"
@implementation PathModel
- (instancetype)init{
    
    if(self = [super init]){
        
        self.taskModel = [[TaskModel alloc] init];
    }
    return self;
}

//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        <#statements#>
//    }
//    return self;
//}
@end
