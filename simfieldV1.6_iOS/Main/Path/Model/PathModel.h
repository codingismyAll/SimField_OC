//
//  PathModel.h
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/6.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TaskModel;

@interface PathModel : NSObject

@property(nonatomic,strong) TaskModel *taskModel;

@property(nonatomic,strong) NSString *taskName;

@property(nonatomic,strong) NSString *code;

@property(nonatomic, strong) NSDictionary *factory;

@property(nonatomic,strong) NSString *name;

@property(nonatomic, strong) NSDictionary *responsible;

@property(nonatomic, strong) NSDictionary *type;

@property(nonatomic, strong) NSArray *checkPoint;



@end
