//
//  AppDelegate+touch.m
//  CX3DTouch
//
//  Created by 陈晓辉 on 2018/10/11.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "AppDelegate+touch.h"

@implementation AppDelegate (touch)

#pragma mark - 3D Touch 触发 系统协议 方法
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    
    //这里可以实现界面跳转等方法
    
    if ([shortcutItem.type isEqualToString:@"item1"]) {
        
        NSLog(@"按压 item1 标题");
    }else if ([shortcutItem.type isEqualToString:@"item2"]) {
        
        NSLog(@"按压 item2 标题");
    }else if ([shortcutItem.type isEqualToString:@"itemN"]) {
        
        NSLog(@"按压 itemN 标题: %@",shortcutItem.userInfo);
    }else if ([shortcutItem.type isEqualToString:@"item_plist"]) {
        
        NSLog(@"按压 item_plist 标题");
    }
}

@end
