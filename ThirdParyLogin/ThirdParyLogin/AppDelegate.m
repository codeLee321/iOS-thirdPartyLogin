//
//  AppDelegate.m
//  ThirdParyLogin
//
//  Created by tony on 16/11/4.
//  Copyright © 2016年 ZThink. All rights reserved.
//

#import "AppDelegate.h"
#import "WXApi.h"
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{


    // 由微信唤起的跳转请求
    if([url.absoluteString hasPrefix:@"wx"]){
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;

}
/*! @brief 发送一个sendReq后，收到微信的回应
 *
 * 收到一个来自微信的处理结果。调用一次sendReq后会收到onResp。
 * 可能收到的处理结果有SendMessageToWXResp、SendAuthResp等。
 * @param resp具体的回应内容，是自动释放的
 */
-(void)onResp:(BaseResp *)resp{
//根据判断是否是登录的
    __weak typeof(self)safeSelf = self;
    /*
    第一步获取权限
    NSString *weixinStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WXLoginId, WXLoginSecret, authResp.code];
    
    [ZTHttpTool nonJSONPOST:weixinStr parameters:nil success:^(id responseObject) {
        
        ZTThirdLoginModel *weixinModel = [ZTThirdLoginModel yy_modelWithJSON:responseObject];
     
    第二步拿到token获取用户信息（userinfo）
        [safeSelf getUserMessageWithOpenid:weixinModel.openid andAccess_Token:weixinModel.access_token];
        
    } failure:^(NSError *error) {
        [ZTHttpHint SVShowNetWorkError];
    }];
     
*/
}
/*
- (void)getUserMessageWithOpenid:(NSString *)openid andAccess_Token:(NSString *)access_token
{
    __weak typeof(self)safeSelf = self;
    NSString *url = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@", access_token, openid];
    [ZTHttpTool nonJSONPOST:url parameters:nil success:^(id responseObject) {
        
        ZTThirdLoginModel *weixinModel = [ZTThirdLoginModel yy_modelWithJSON:responseObject];
        if (weixinModel.sex == 1) {
            weixinModel.gender = @"男";
        } else if (weixinModel.sex == 2) {
            weixinModel.gender = @"女";
        }
        
    这是一个代理的回掉的方法，根据拿到的用户信息进行登录
        if (safeSelf.delegate && [safeSelf.delegate respondsToSelector:@selector(getUserInfoModel:andOpenId:)]) {
            [safeSelf.delegate getUserInfoModel:weixinModel andOpenId:weixinModel.openid];
        }
        
    } failure:^(NSError *error) {
        [ZTHttpHint SVShowNetWorkError];
    }];
}
 */

#define WXAppId                     @"wx869eefe144a47f5b"                /**< 微信开发者ID*/
#define WXAppSecret                 @"694a536d5044bb3d8424628df89fb819"  /**< 微信AppSecret*/
#define WXLoginId                   @"wx869eefe144a47f5b"                /**< 微信登录*/
#define WXLoginSecret               @"694a536d5044bb3d8424628df89fb819"  //
@end
