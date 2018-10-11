//
//  ViewController.m
//  CX3DTouch
//
//  Created by 陈晓辉 on 2018/10/10.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "ViewController.h"
#import "CXTouchViewController.h"
#import <SafariServices/SafariServices.h>

#define CX_URL @"https://m.baidu.com"

@interface ViewController ()<UIViewControllerPreviewingDelegate,SFSafariViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIButton *showButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self check3DTouch];
}
#pragma mark ---------- 当前视图注册 3DTouch ----------
//MARK: 检测是否支持 3DTouch
- (void)check3DTouch {
    
    //判断当前设备是否支持 3DTouch
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        
        //当前设备支持  注册 3DTouch 代理
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    }
}
#pragma mark ---------- UIViewControllerPreviewingDelegate ----------
// If you return nil, a preview presentation will not be performed
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0) {
    
    //location 就是重压坐标, 如果按压在 指定坐标范围上时, 执行
    if (CGRectContainsPoint(self.showLabel.frame,location)) { //按压 在 label 上
        
        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:CX_URL]];
        
        safariVC.delegate = self;
        //第一次按压时, 弹出的窗口尺寸, 再次按压 则跳转到 safariVC
        safariVC.preferredContentSize = CGSizeMake(0, [[UIScreen mainScreen] bounds].size.height-200);
        safariVC.navigationItem.title = @"baidu";
        
        //设置高亮区域
        previewingContext.sourceRect = self.showLabel.frame;
        return safariVC;
    }else if (CGRectContainsPoint(self.showButton.frame, location)) { //按压 在 button 上
        
        CXTouchViewController *touchVC = [[CXTouchViewController alloc] init];
        touchVC.navigationItem.title = @"3DTouch -> touchVC";
        touchVC.view.backgroundColor = [UIColor magentaColor];
        touchVC.preferredContentSize = CGSizeMake(0, [[UIScreen mainScreen] bounds].size.height-200);
        
        //轻按 高亮范围, 可以没有
        previewingContext.sourceRect = self.showButton.frame;
        
        return touchVC;
    }
    return nil;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit NS_AVAILABLE_IOS(9_0) {
    
    //固定写法, 将要显示一个 VC
    [self showViewController:viewControllerToCommit sender:self];
}

#pragma mark ---------- SFSafariViewControllerDelegate ----------
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    
    //这里根据 VC 弹出的方式进行选择
    //[controller dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ---------- 按钮点击 ----------
- (IBAction)showButtonAction:(id)sender {
    
    CXTouchViewController *touchVC = [[CXTouchViewController alloc] init];
    touchVC.navigationItem.title = @"button -> touchVC";
    touchVC.view.backgroundColor = [UIColor magentaColor];
    [self.navigationController pushViewController:touchVC animated:YES];
}

@end
