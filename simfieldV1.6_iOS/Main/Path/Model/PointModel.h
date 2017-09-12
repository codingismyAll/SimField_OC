//
//  PointModel.h
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/16.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointModel : NSObject

@property(nonatomic, strong) NSDictionary *NFC;

@property(nonatomic, strong) NSDictionary *RFID;

@property(nonatomic, strong) NSString *allowSkip;

@property(nonatomic, strong) NSString *code;

@property(nonatomic, strong) NSString *manual;

@property(nonatomic, strong) NSString *name;

@property(nonatomic, strong) NSDictionary *pointResponsible;

@property(nonatomic, strong) NSDictionary *position;

@property(nonatomic, strong) NSString *sequnce;

@property(nonatomic, strong) NSDictionary *twoDCode;

@property (nonatomic, strong) NSArray *checkItem;



@end
