//
//  CX3DTouch.m
//  CX3DTouch
//
//  Created by 陈晓辉 on 2018/10/11.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CX3DTouch.h"
#import <UIKit/UIKit.h>
@implementation CX3DTouch

+ (void)load {
    
    [self shareManager];
}

+ (CX3DTouch *)shareManager {
    static CX3DTouch *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CX3DTouch alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        //监听程序启动完成通知
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            
            [self createTouchItems];
        }];
    }
    return self;
}
- (void)createTouchItems {
    
    //3D Touch 分为重压和轻压手势, 分别称作 POP(第一段重压) 和 PEEK(第二段重压), 外面的图标只需要 POP 即可;
    
    //3D Touch 添加小组件 ???
    
    //1.  POP 手势图标初始化
    //1.1 使用系统自带图标
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove];
    
    //1.2 使用自己的 icon
    UIApplicationShortcutIcon *iconN = [UIApplicationShortcutIcon iconWithTemplateImageName:@"f_service_nor"];
    
    //2. 创建触发事件 item
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"item1" localizedTitle:@"扫描" localizedSubtitle:@"盯住二维码" icon:icon1 userInfo:nil];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"item2" localizedTitle:@"付款" localizedSubtitle:@"霸王餐执行者" icon:icon2 userInfo:nil];
    UIApplicationShortcutItem *itemN = [[UIApplicationShortcutItem alloc] initWithType:@"itemN" localizedTitle:@"加好友" localizedSubtitle:@"黑名单?" icon:iconN userInfo:@{@"userId":@"123"}];
    
    //3. 将 item 添加到事件列表
    [UIApplication sharedApplication].shortcutItems = @[item1,item2,itemN];
}

@end
