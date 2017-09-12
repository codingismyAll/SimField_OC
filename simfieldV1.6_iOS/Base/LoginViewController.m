//
//  LoginViewController.m
//  simfieldV1.6_iOS
//
//  Created by admin on 17/7/28.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "LoginViewController.h"
#import "FXAnimationField.h"
#import "HomeViewController.h"
#import "AFNetworking.h"
#import "GDataXMLNode.h"


@interface LoginViewController ()


@property (strong, nonatomic)FXAnimationField *emailAnimationField;
@property (strong, nonatomic)FXAnimationField *passwordAnimationField;
@property (strong, nonatomic)UIImageView *phoneImage;
@property (strong, nonatomic)UIImageView *passwordImage;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bg.png"]];
    
    [self setTitleLabel];
    [self setButton];
    [self.view addSubview:self.emailAnimationField];
    [self.view addSubview:self.passwordAnimationField];
    [self.view addSubview:self.phoneImage];
    [self.view addSubview:self.passwordImage];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


- (void)setTitleLabel{
    
    UILabel *titleLabel =[[UILabel alloc] init];
    titleLabel.text = @"SimField移动应用平台";
    //    [titleLabel sizeToFit];
    //设置字体颜色为白色
    titleLabel.textColor = [UIColor whiteColor];
    //文字居中显示
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(0, 60, self.view.frame.size.width, 70);
    titleLabel.font = [UIFont systemFontOfSize:24];
    
    [self.view addSubview:titleLabel];
    
}

- (void)setButton{
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(15, 380, self.view.frame.size.width-30, 60);
    [loginButton setTitle:@"登  录" forState:UIControlStateNormal];
    loginButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    
//    [loginButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
   
    //使文字距离做边框保持20个像素的距离。不过设置了没有作用
//    loginButton.contentEdgeInsets = UIEdgeInsetsMake(0,20, 0, 0);
    
    loginButton.clipsToBounds=YES;
    loginButton.layer.cornerRadius = 5;
//    [loginButton setBackgroundImage:[UIImage imageNamed:@"table_single_blue"] forState:UIControlStateNormal];
    loginButton.backgroundColor = [UIColor colorWithRed:65/255.0f green:105/255.0f blue:225/255.0f alpha:1.0];
    [loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:loginButton];
}

- (void)login{
    
//    NSString *username = self.emailAnimationField.textInput;
//    NSString *password = self.passwordAnimationField.textInput;
    NSString *urlAsString = [NSString stringWithFormat:@"http://10.30.28.240:8087/cas/mobile/logon?username=df&password=12345678&clientType=ios&clientVersion=2.1"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //发起GET请求
    [manager GET:urlAsString
      parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
        }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSData *data = (NSData *)responseObject;
//             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//             
//             NSLog(@"dic = %@",dic);
             
             NSLog(@"login xml:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
             
//             GDataXMLDocument *doc = (GDataXMLDocument *) [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSError *error;
             GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
            
             /**
              <bindFlag></bindFlag>
              <cinfo></cinfo>
              
              */
             NSArray *results = [doc nodesForXPath:@"//result" error:nil];

             GDataXMLElement *bindFlag = [results objectAtIndex:0];
             NSArray *elementArray = [bindFlag elementsForName:@"bindFlag"];
             GDataXMLElement *gdataElement = (GDataXMLElement *)[elementArray objectAtIndex:0];
             NSLog(@"gdataElement = %@",gdataElement.stringValue);

             
             NSArray *companys = [doc nodesForXPath:@"//result/cinfo/COMPANYINFOS/COMPANYS/COMPANY" error:nil];
             GDataXMLElement *company = [companys objectAtIndex:0];
             NSArray *elementArray2 =  [company elementsForName:@"JSEESIONID"];
             GDataXMLElement *gg = (GDataXMLElement *)[elementArray2 objectAtIndex:0];
             
             NSLog(@"gg = %@", gg.stringValue);

             
             
             
             NSArray                 *cookies;
        
             NSDictionary            *cookieHeaders;
//             NSURL *cookieUrl = [NSURL URLWithString:@"http://10.30.28.240:8087"];
//             cookies = [[ NSHTTPCookieStorage sharedHTTPCookieStorage ] cookiesForURL: cookieUrl ];
//             NSLog(@"cookies = %@",cookies);
//             cookieHeaders = [NSHTTPCookie requestHeaderFieldsWithCookies: cookies];
//             NSLog(@"cookieHeaders = %@",cookieHeaders);

             
             
             
             NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)task.response;
//            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)responseObject;

             
             //NSURL *url = [NSURL URLWithString:@"http://10.30.28.240:8087"];
//             cookies = [NSHTTPCookie cookiesWithResponseHeaderFields:[httpResponse allHeaderFields] forURL:url];
//             
//             NSMutableArray *newCookies = [NSMutableArray array];
//             for (NSHTTPCookie *cookie in cookies){
//                 //NSLog(@"Name: %@ : Value: %@, Expires: %@", cookie.name, cookie.value, cookie.expiresDate);
//                 if (![cookie.path isEqualToString:@"/"]) {
//                     continue;
//                 }
//                 
//                 NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
//                 [cookieProperties setObject:cookie.name forKey:NSHTTPCookieName];
//                 [cookieProperties setObject:cookie.value forKey:NSHTTPCookieValue];
//                 [cookieProperties setObject:cookie.domain forKey:NSHTTPCookieDomain];
//                 [cookieProperties setObject:url forKey:NSHTTPCookieOriginURL];
//                 [cookieProperties setObject:@"/" forKey:NSHTTPCookiePath];
//                 [cookieProperties setObject:@"0" forKey:NSHTTPCookieVersion];
//                 
//                 // set expiration to one month from now or any NSDate of your choosing
//                 // this makes the cookie sessionless and it will persist across web sessions and app launches
//                 [cookieProperties setObject:[[NSDate date] dateByAddingTimeInterval:2629743] forKey:NSHTTPCookieExpires];
//                 
//                 NSHTTPCookie *newCookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
//                 
//                 [newCookies addObject:newCookie];
//                 
//            
//             }
//             
//             [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:newCookies forURL: url mainDocumentURL:nil];
             
             
             
             HomeViewController *homeVC = [[HomeViewController alloc] init];
             
             [self.navigationController pushViewController:homeVC animated:YES];
             
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"请求失败");
             HomeViewController *homeVC = [[HomeViewController alloc] init];
             
             [self.navigationController pushViewController:homeVC animated:YES];
         }];
    
    
    
    

//    [self presentViewController:homeVC animated:YES completion:nil];
}





- (FXAnimationField *)emailAnimationField {
    if (!_emailAnimationField) {
        _emailAnimationField = [[FXAnimationField alloc]initWithFrame:CGRectMake(55, 200, self.view.frame.size.width-70, 40)];
        _emailAnimationField.textFiled.borderStyle =  UITextBorderStyleNone;
        _emailAnimationField.placeholderColor = [UIColor lightGrayColor];
        _emailAnimationField.placeStr = @"用户名";
        _emailAnimationField.placeholderFont = [UIFont systemFontOfSize:15];
        //_emailAnimationField.textColor = [UIColor greenColor];
        _emailAnimationField.animationType = FXAnimationTypeUp;
    }
    return _emailAnimationField;
}

- (FXAnimationField *)passwordAnimationField {
    if (!_passwordAnimationField) {
        _passwordAnimationField = [[FXAnimationField alloc]initWithFrame:CGRectMake(55, 280, self.view.frame.size.width-70, 40)];
        _passwordAnimationField.textFiled.borderStyle =  UITextBorderStyleNone;
        _passwordAnimationField.placeholderColor = [UIColor lightGrayColor];
        _passwordAnimationField.placeStr = @"用户密码";
        _passwordAnimationField.placeholderFont = [UIFont systemFontOfSize:15];
        //_passwordAnimationField.textColor = [UIColor greenColor];
        _passwordAnimationField.animationType = FXAnimationTypeUp;
    }
    return _passwordAnimationField;
    
}

- (UIImageView *)phoneImage {
    if (!_phoneImage) {
        _phoneImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 205, 24, 24)];
        _phoneImage.image  = [UIImage imageNamed:@"login_moblie"];
    }
    return _phoneImage;
    
}

- (UIImageView *)passwordImage {
    if (!_passwordImage) {
        _passwordImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 285, 24, 24)];
        _passwordImage.image = [UIImage imageNamed:@"login_passcode"];
    }
    return _passwordImage;
}


- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
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
