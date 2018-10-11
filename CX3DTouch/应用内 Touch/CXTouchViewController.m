//
//  CXTouchViewController.m
//  CX3DTouch
//
//  Created by 陈晓辉 on 2018/10/11.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXTouchViewController.h"

@interface CXTouchViewController ()<UIPreviewActionItem>

@end

@implementation CXTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark ---------- UIPreviewActionItem ----------
//显示上划触发按钮
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    
    UIPreviewAction *action = [UIPreviewAction actionWithTitle:@"标题1" style:(UIPreviewActionStyleDefault) handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        NSLog(@"点击了 标题1");
    }];
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"标题2" style:(UIPreviewActionStyleSelected) handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        NSLog(@"点击了 标题2");
    }];
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"标题3" style:(UIPreviewActionStyleDestructive) handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
        NSLog(@"点击了 标题3");
    }];
    
    return @[action,action2,action3];
}
- (UIViewController *)topViewController {
    return [self topViewControllerWithRootViewController:[[UIApplication sharedApplication] delegate].window.rootViewController];
}
//MARK: 获取当前显示的 VC
- (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        
        return rootViewController;
    }
}

@end
