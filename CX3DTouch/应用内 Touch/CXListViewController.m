//
//  CXListViewController.m
//  CX3DTouch
//
//  Created by 陈晓辉 on 2018/10/11.
//  Copyright © 2018年 陈晓辉. All rights reserved.
//

#import "CXListViewController.h"
#import "CXTouchViewController.h"

@interface CXListViewController ()<UITableViewDataSource,UIViewControllerPreviewingDelegate>

@end

@implementation CXListViewController {
    
    UITableView *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"ListViewController";
    
    [self loadTableView];
}


- (void)loadTableView {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.rowHeight = 60;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    _tableView = tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"第 %ld 行",(long)indexPath.row];
    
    //注册 3DTouch 代理
    [self registerForPreviewingWithDelegate:self sourceView:cell];
    
    return cell;
}

#pragma mark ---------- UIViewControllerPreviewingDelegate ----------
// If you return nil, a preview presentation will not be performed
- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location NS_AVAILABLE_IOS(9_0) {
    
    //location 就是重压坐标, 如果按压在 指定坐标范围上时, 执行
    NSIndexPath *indexPath = [_tableView indexPathForCell:(UITableViewCell *)[previewingContext sourceView]];
    
    //
    NSArray *arr = @[@"list_0",@"list_1",@"list_2",@"list_3",@"list_4",@"list_5",@"list_6",@"list_7",@"list_8",@"list_9"];
    NSArray *colorArr = @[[UIColor cyanColor],[UIColor orangeColor],[UIColor purpleColor]];
    //
    CXTouchViewController *touchVC = [CXTouchViewController new];
    touchVC.view.backgroundColor = colorArr[indexPath.row %3];
    touchVC.navigationItem.title = arr[indexPath.row];
    touchVC.preferredContentSize = CGSizeMake(0.0f,600.f);//设置显示的视图范围大小
    return touchVC;
}
- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit NS_AVAILABLE_IOS(9_0) {
    
    //固定写法, 将要显示一个 VC
    [self showViewController:viewControllerToCommit sender:self];
}

@end
