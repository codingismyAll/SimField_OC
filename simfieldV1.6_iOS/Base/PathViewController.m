//
//  PathViewController.m
//  simfieldV1.6_iOS
//
//  Created by 丁峰 on 2017/8/1.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "PathViewController.h"
#import "AFNetworking.h"
#import <sqlite3.h>
#import "TaskModel.h"
#import "PathViewCell.h"
#import "PathModel.h"
#import "PointViewController.h"
#import "YYCache.h"

@interface PathViewController () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_dataArray;
}
@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

@implementation PathViewController

static sqlite3 *db;//是指向数据库的指针,我们其他操作都是用这个指针来完成


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"巡检线路";
    
    //只显示有数据的分割线
    self.listTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下载" style:UIBarButtonItemStylePlain target:self action:@selector(download)];
    
    //注册单元格
    UINib *nib = [UINib nibWithNibName:@"PathViewCell" bundle:[NSBundle mainBundle]];
   
    [self.listTableView registerNib:nib forCellReuseIdentifier:@"PathViewCellID"];
    
    

    
//    [self download];
    
//    [self YYSaveData];
    
    [self _parseJsonData2];
}

- (void)back{
   
    UITabBarController * tabbarCtl = self.tabBarController;
    UINavigationController * nav = tabbarCtl.navigationController;
    [nav popViewControllerAnimated:YES];

}

- (void)download{
    
//    [self openSqlite];
//    [self createTable];
    
    NSString *urlAsString = [NSString stringWithFormat:@"http://10.30.28.240:8087/patrol/patrolItem/patrolItem/AppPatrolCheckTaskDownload.action?availableOnly=true"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSArray                 *cookies;
    NSDictionary            *cookieHeaders;
    NSURL *cookieUrl = [NSURL URLWithString:@"http://10.30.28.240:8087"];
    cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage ] cookiesForURL: cookieUrl ];
    NSLog(@"cookies = %@",cookies);
    cookieHeaders = [NSHTTPCookie requestHeaderFieldsWithCookies: cookies];
    NSLog(@"cookieHeaders = %@",cookieHeaders);
    [manager.requestSerializer setValue:[cookieHeaders objectForKey: @"Cookie"] forHTTPHeaderField:@"Cookie"];
    
    [manager GET:urlAsString
      parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
        }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
//             NSString *result3 = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//             NSLog(@"result3 = %@",result3);
             
             NSData *data = (NSData *)responseObject;
             
             [self YYSaveData:data];

             
//             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//             
//                          NSLog(@"dic = %@",dic);
//             [self addTask:dic];
//             NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
           
             //添加任务到数据库中
//             [self addTask:dataString];

             
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"请求失败");
         }];

}

#pragma mark - 2.打开数据库

- (void)openSqlite {
    //判断数据库是否为空,如果不为空说明已经打
    if(db != nil) {
        NSLog(@"数据库已经打开");
        return;
    }
    
    //获取文件路径
    NSString *str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *strPath = [str stringByAppendingPathComponent:@"my.sqlite"];
    NSLog(@"%@",strPath);
    //打开数据库
    //如果数据库存在就打开,如果不存在就创建一个再打开
    int result = sqlite3_open([strPath UTF8String], &db);
    //判断
    if (result == SQLITE_OK) {
        NSLog(@"数据库打开成功");
    } else {
        NSLog(@"数据库打开失败");
    }
}


#pragma mark - 3.增删改查
//创建表格
- (void)createTable {
    //1.准备sqlite语句
    //    NSString *sqlite = [NSString stringWithFormat:@"create table if not exists 'student' ('number' integer primary key autoincrement not null,'name' text,'sex' text,'age'integer)"];
    
    NSString *taskSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'tasks' ('username' text,'downloadTime' text, 'taskInfo' text,id integer primary key)"];
    
    /**
    NSString *checklineSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'checklines' ('username' text,'taskname' text, 'taskcode' text, 'allowTime' text ,'status' text, 'linecode' text, 'factoryname' text, 'factorycode' text, 'name' text,'responsiblename' text, 'responsiblecode' text, 'typecode' text, 'typename' text, id integer primary key)"];
    
    NSString *checkpointSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'checkpoints' ('username' text, 'taskcode' text, 'linename' text, 'linecode' text, 'pointcode' text, 'manual' text, 'name' text, 'pointResponsiblecode' text, 'pointResponsiblename' text, 'positiondeviation' text, 'positionenable' text, 'positionlabel' text, 'sequnce' text, 'allowSkip' text, 'NFCenabled' text, 'NFClable' text, 'RFIDenabled' text, 'RFIDlabel' text, 'twoDCodeenabled' text,'twoDCodelabel' text,i d integer primary key)"];
    
    NSString *checkitemSql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS 'checkItems' ('username' text, 'taskcode' text , 'linename' text, 'pointname' text, 'itemcode' text, 'allowSkip' text, 'name' text, 'type' text, 'EnumAll' text, 'ValStd' text, 'DateStd' text, id integer primary key)"];
    
    */
    //2.执行sqlite语句
    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
    int taskResult = sqlite3_exec(db, [taskSql UTF8String], nil, nil, &error);
//    int lineResult = sqlite3_exec(db, [checklineSql UTF8String], nil, nil, &error);
//    int pointResult = sqlite3_exec(db, [checkpointSql UTF8String], nil, nil, &error);
//    int itemResult = sqlite3_exec(db, [checkitemSql UTF8String], nil, nil, &error);

    
    //3.sqlite语句是否执行成功
    
    if (taskResult == SQLITE_OK ) {
        NSLog(@"创建表成功");
        
    } else {
        NSLog(@"创建表失败");
    }
}

//添加数据

- (void)addTask:(NSString *)str{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    NSString *sqlite = [NSString stringWithFormat:@"insert into tasks(username,downloadTime,taskInfo) values ('%@','%@','%@')",@"df", currentTimeString, str];
    
    //2.执行sqlite语句
    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
    int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);

    if (result == SQLITE_OK) {
        
        NSLog(@"添加任务数据成功");
        [self _parseJsonData];
    } else {
        NSLog(@"添加任务数据失败:%s",error);
//        [self _parseJsonData];

    }

}

/**
- (void)addTask:(NSDictionary *)dic{
 
    if([dic[@"task"] isKindOfClass:[NSArray class]]){
        NSArray *taskArr = dic[@"task"];
        for(NSInteger i = 0; i < taskArr.count; i++){
            //1.准备sqlite语句
            
            NSString *sqlite = [NSString stringWithFormat:@"insert into tasks(username,taskcode,name,status,checker,allowTime) values ('%@','%@','%@','%@','%@','%@')",@"df", taskArr[i][@"code"], taskArr[i][@"name"], taskArr[i][@"status"], taskArr[i][@"checker"], taskArr[i][@"allowTime"]];
            
            //2.执行sqlite语句
            char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
            int result = sqlite3_exec(db, [sqlite UTF8String], nil, nil, &error);
            if (result == SQLITE_OK) {
                NSLog(@"添加任务第%ld数据成功",i);
            } else {
                NSLog(@"添加任务%ld数据失败", i);
            }
            if([taskArr[i][@"checkLine"] isKindOfClass:[NSArray class]]){

                NSArray *lineArr = taskArr[i][@"checkLine"];
                
                for (NSInteger j = 0; j < lineArr.count; j++) {
                    
                   
                    NSString *lineSqlite = [NSString stringWithFormat:@"insert into checklines(username,taskname,taskcode,allowTime,status,linecode,factoryname,factorycode,name,responsiblename,responsiblecode,typecode,typename) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",@"df", taskArr[i][@"name"], taskArr[i][@"code"], taskArr[i][@"allowTime"], taskArr[i][@"status"], lineArr[j][@"code"], lineArr[j][@"factory"][@"name"], lineArr[j][@"factory"][@"code"], lineArr[j][@"name"], lineArr[j][@"responsible"][@"name"], lineArr[j][@"responsible"][@"code"], lineArr[j][@"type"][@"code"], lineArr[j][@"type"][@"name"] ];
                    
                    //2.执行sqlite语句
                    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
                    int result = sqlite3_exec(db, [lineSqlite UTF8String], nil, nil, &error);
                    if (result == SQLITE_OK) {
                        NSLog(@"添加线路第%ld数据成功", j);
                    } else {
                        NSLog(@"添加线路%ld数据失败", j);
                    }
                    if([lineArr[j][@"checkPoints"] isKindOfClass:[NSArray class]]){
                        NSArray *pointArr = lineArr[j][@"checkPoint"];
                       
                        for (NSInteger k = 0; k < pointArr.count; k++) {
                            
                            NSString *pointSql = [NSString stringWithFormat:@"INSERT INTO checkpoints (username,taskcode,linename, linecode,pointcode, manual, name,pointResponsiblecode,pointResponsiblename,positiondeviation,positionenable,positionlabel,sequnce,allowSkip,NFCenabled,NFClable, RFIDenabled, RFIDlabel,twoDCodeenabled,twoDCodelabel) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')", @"df", taskArr[i][@"code"], lineArr[j][@"name"], lineArr[j][@"code"], pointArr[k][@"code"], pointArr[k][@"manual"], pointArr[k][@"name"], pointArr[k][@"pointResponsible"][@"code"], pointArr[k][@"pointResponsible"][@"name"], pointArr[k][@"position"][@"deviation"], pointArr[k][@"position"][@"enabled"], pointArr[k][@"position"][@"label"], pointArr[k][@"sequnce"], pointArr[k][@"allowSkip"], pointArr[k][@"NFC"][@"enabled"], pointArr[k][@"NFC"][@"label"], pointArr[k][@"RFID"][@"enabled"], pointArr[k][@"RFID"][@"label"], pointArr[k][@"twoDCode"][@"enabled"], pointArr[k][@"twoDCode"][@"label"]];
                            
                            //2.执行sqlite语句
                            char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
                            int result = sqlite3_exec(db, [pointSql UTF8String], nil, nil, &error);
                            if (result == SQLITE_OK) {
                                NSLog(@"添加点第%ld数据成功", k);
                            } else {
                                NSLog(@"添加点%ld数据失败", k);
                            }
                            
                            if([pointArr[k][@"checkItem"] isKindOfClass:[NSArray class]]){
                                NSArray *itemArr = pointArr[k][@"checkItem"];
                               
                                for (NSInteger l = 0; l < itemArr.count; l++) {
                                    NSString *itemSql = [NSString stringWithFormat:@"INSERT INTO checkItems (username,taskcode,linename,pointname, itemcode,allowSkip,name,type) values ('%@','%@','%@','%@','%@','%@','%@','%@')",@"df", taskArr[i][@"code"], lineArr[j][@"name"], pointArr[k][@"name"], itemArr[l][@"code"], itemArr[l][@"allowSkip"], itemArr[l][@"name"], itemArr[l][@"type"]];
                                    
                                    //2.执行sqlite语句
                                    char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
                                    int result = sqlite3_exec(db, [itemSql UTF8String], nil, nil, &error);
                                    if (result == SQLITE_OK) {
                                        NSLog(@"添加项第%ld数据成功", l);
                                    } else {
                                        NSLog(@"添加项%ld数据失败", l);
                                    }
                                    if(itemArr[l][@"stdDate"] != NULL){
                                        NSString *dateQuery = [NSString stringWithFormat:@"UPDATE checkitems SET DateStd = '%@' WHERE itemcode = '%@'", itemArr[l][@"stdDate"][@"standard"], itemArr[l][@"code"]];
                                        
                                        //2.执行sqlite语句
                                        char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
                                        int result = sqlite3_exec(db, [dateQuery UTF8String], nil, nil, &error);
                                        if (result == SQLITE_OK) {
                                            NSLog(@"添加项第%ld数据成功", l);
                                        } else {
                                            NSLog(@"添加项%ld数据失败", l);
                                        }
                                    }else if (itemArr[l][@"stdValue"] != NULL){
                                        NSString *dateQuery = [NSString stringWithFormat:@"UPDATE checkitems SET DateStd = '%@' WHERE itemcode = '%@'", itemArr[l][@"stdDate"][@"standard"], itemArr[l][@"code"]];
                                        
                                        //2.执行sqlite语句
                                        char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
                                        int result = sqlite3_exec(db, [dateQuery UTF8String], nil, nil, &error);
                                        if (result == SQLITE_OK) {
                                            NSLog(@"添加项第%ld数据成功", l);
                                        } else {
                                            NSLog(@"添加项%ld数据失败", l);
                                        }
                                    }else{
                                        
                                    }
                                    

                                }
                            }
                        }
                        
                 
                    }
                    
                  
                }

            }
            
            
            

        }
    }
    
   }
*/

//解析数据
- (void)_parseJsonData{
    
    NSString *taskSelectSql = [NSString stringWithFormat:@"SELECT * FROM tasks WHERE username = '%@'",@"df"];
    //2.执行sqlite语句
    
    sqlite3_stmt *stmt = NULL;

    const char *error = NULL;//执行sqlite语句失败的时候,会把失败的原因存储到里面
    int taskResult = sqlite3_prepare_v2(db, [taskSelectSql UTF8String], -1, &stmt, &error);

    
    
    //3.sqlite语句是否执行成功
    _dataArray = [[NSMutableArray alloc] init];
    
    if (taskResult == SQLITE_OK ) {
       
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            NSString *taskString = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            NSData *taskData = [taskString dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:taskData options:NSJSONReadingMutableLeaves error:nil];
            
            NSArray *subject = dic[@"task"];
            for (NSDictionary *dataDic in subject) {
/**             TaskModel *taskModel = [[TaskModel alloc] init];
              taskModel.allowTime = dataDic[@"allowTime"];
                taskModel.checker = dataDic[@"checker"];
                taskModel.code = dataDic[@"code"];
                taskModel.name = dataDic[@"name"];
                taskModel.status = dataDic[@"status"];
 */
                NSArray *pathArr = dataDic[@"checkLine"];
                
                for (NSDictionary *pathDic in pathArr) {
                    PathModel *pathModel = [[PathModel alloc] init];
                    pathModel.taskModel.name = dataDic[@"name"];
                    pathModel.code = pathDic[@"code"];
                    pathModel.factory = pathDic[@"factory"];
                    pathModel.name = pathDic[@"name"];
                    pathModel.responsible = pathDic[@"responsible"];
                    pathModel.type = pathDic[@"type"];
                    pathModel.checkPoint = pathDic[@"checkPoint"];
                    
                    [_dataArray addObject:pathModel];

                }
                
            }
            NSLog(@"_dataArray = %@",_dataArray);
        }
       
        [self.listTableView reloadData];
        
    } else {
        NSLog(@"取出数据失败");
    }
    
//    销毁stmt,回收资源
    sqlite3_finalize(stmt);
//    sqlite3_close(db);
    
    
    
}



- (void)_parseJsonData2{
    
    //根据key读取数据
    YYCache *yyCache=[YYCache cacheWithName:@"TaskCache"];
    id value = [yyCache objectForKey:@"taskKey"];
    NSLog(@"value : %@",value);

    if(value){
        
        _dataArray = [[NSMutableArray alloc] init];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:value options:NSJSONReadingMutableLeaves error:nil];
        
        NSArray *subject = dic[@"task"];
        for (NSDictionary *dataDic in subject) {
            NSArray *pathArr = dataDic[@"checkLine"];
            
            for (NSDictionary *pathDic in pathArr) {
                PathModel *pathModel = [[PathModel alloc] init];
                pathModel.taskModel.name = dataDic[@"name"];
                pathModel.code = pathDic[@"code"];
                pathModel.factory = pathDic[@"factory"];
                pathModel.name = pathDic[@"name"];
                pathModel.responsible = pathDic[@"responsible"];
                pathModel.type = pathDic[@"type"];
                pathModel.checkPoint = pathDic[@"checkPoint"];
                
                [_dataArray addObject:pathModel];
                
            }
            
        }
        NSLog(@"_dataArray = %@",_dataArray);
        
        [self.listTableView reloadData];
    }



}
//利用YYcache存储数据
- (void)YYSaveData:(NSData *)data{
    
    //模拟一个key
    //同步方式
    NSString *key=@"taskKey";
    YYCache *yyCache=[YYCache cacheWithName:@"TaskCache"];
    //先清空，根据key移除缓存
    [yyCache removeObjectForKey:key];
    //根据key写入缓存value
    [yyCache setObject:data forKey:key];
    //判断缓存是否存在
    BOOL isContains=[yyCache containsObjectForKey:key];
    NSLog(@"containsObject : %@", isContains?@"YES":@"NO");

    if(isContains){
        [self _parseJsonData2];
    }
    //移除所有缓存
//    [yyCache removeAllObjects];
}


//读取数据
#pragma - mark tableview datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
} 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    PathViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PathViewCellID" forIndexPath:indexPath];
    cell.pathModel = _dataArray[indexPath.row];
    
    return cell;
    
}
#pragma - mark tableview delegate

//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PathModel *pathModel = [[PathModel alloc] init];
    pathModel = _dataArray[indexPath.row];
    
    PointViewController *pointVC = [[PointViewController alloc] init];
    
    pointVC.checkPoint = pathModel.checkPoint;
    pointVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pointVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
