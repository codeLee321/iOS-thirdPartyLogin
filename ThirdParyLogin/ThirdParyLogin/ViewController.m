//
//  ViewController.m
//  ThirdParyLogin
//
//  Created by tony on 16/11/4.
//  Copyright © 2016年 ZThink. All rights reserved.
//

#import "ViewController.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import "WXApi.h"
@interface ViewController ()<TencentSessionDelegate>
/**<QQ*/
@property (nonatomic, strong) TencentOAuth *tencentOAuth;
/**<weixin*/
@property (nonatomic, strong) SendAuthReq *sendAuthReq;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark ---- QQ Login -------
-(TencentOAuth *)tencentOAuth{
    if (!_tencentOAuth) {
        _tencentOAuth = [[TencentOAuth alloc]initWithAppId:@"yourAppid" andDelegate:self];
    }

    return _tencentOAuth;
}

//登录
-(void)qqLogin{

    [self.tencentOAuth authorize:
     @[@"get_user_info",
     @"get_simple_userinfo",
     @"add_t"] inSafari:NO];

}

#pragma mark ---- QQ登录回掉
-(void)tencentDidNotLogin:(BOOL)cancelled{

}
-(void)tencentDidNotNetWork{

}
-(void)tencentDidLogin{
//登录成功获取用户信息
    [self.tencentOAuth getUserInfo];
}
//获取用户信息的回掉
-(void)getUserInfoResponse:(APIResponse *)response{

    NSDictionary * jsonDict = response.jsonResponse;
    NSLog(@"jsonDict = %@",jsonDict);
    //接下来取出字典里面的内容进行登录 ....
/**< 还需要
     self.tencentOAuth.openId
     用户授权登录后对该用户的唯一标识
 */
}

#pragma mark ---- weixin Login -----
-(SendAuthReq *)sendAuthReq{
    if (!_sendAuthReq) {
        
        _sendAuthReq = [[SendAuthReq alloc]init];
        /** 第三方程序要向微信申请认证，并请求某些权限，需要调用WXApi的sendReq成员函数，向微信终端发送一个SendAuthReq消息结构。微信终端处理完后会向第三方程序发送一个处理结果。
         * @see SendAuthResp
         * @note scope字符串长度不能超过1K
         */
        _sendAuthReq.scope = @"snsapi_userinfo,snsapi_base";
        /** 第三方程序本身用来标识其请求的唯一性，最后跳转回第三方程序时，由微信终端回传。
         * @note state字符串长度不能超过1K
         */
        _sendAuthReq.state = @"123";
        
    }
    return _sendAuthReq;
}

//微信登录
-(void)weixinLogin{


    [WXApi sendReq:self.sendAuthReq];

}
#pragma makrk --- 回掉方法见AppDelegate
@end
