//
//  ItemModel.h
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject

@property(nonatomic, strong) NSString *allowSkip;

@property(nonatomic, strong) NSString *code;

@property(nonatomic, strong) NSString *name;

@property(nonatomic, strong) NSString *stdDate;

@property(nonatomic, strong) NSDictionary *stdEnum;

@property(nonatomic, strong) NSString *stdValue;

@property(nonatomic, strong) NSString *type;


@end
