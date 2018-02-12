//
//  SettingBaseViewController.m
//  ZHSettingView
//
//  Created by 李保征 on 2018/2/12.
//  Copyright © 2018年 李保征. All rights reserved.
//

#import "SettingBaseViewController.h"
#import "SettingBaseCell.h"

@interface SettingBaseViewController ()<UITableViewDataSource,UITableViewDelegate,SettingBaseCellDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation SettingBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat systemVersion = [UIDevice currentDevice].systemVersion.floatValue;
    if (systemVersion >= 11.0) {
        if ([self.tableView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:self.tableView];
}

#pragma mark - getter

- (NSMutableArray <GroupModel*> *)groups{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat tableViewY = 64;
        CGFloat tableViewH = self.view.bounds.size.height - tableViewY;
        CGFloat tableViewX = 0;
        CGFloat tableViewW = self.view.bounds.size.width;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(tableViewX, tableViewY, tableViewW, tableViewH) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor clearColor];
//        _tableView.backgroundColor = [UIColor orangeColor];
        
        //控制器遵守代理
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        //        _<#tableViewName#>.separatorInset = UIEdgeInsetsZero;
        //        _<#tableViewName#>.separatorColor = [UIColor blackColor];
        
        //去除没有数据时显示分割线bug
        _tableView.tableFooterView = [[UIView alloc] init];
        
        _tableView.allowsSelectionDuringEditing = YES;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    GroupModel *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingBaseCell *cell = [SettingBaseCell cellWithTableView:tableView];
    GroupModel *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    cell.delegate = self;
    // 设置cell所处的行号 和 所处组的总行数
//    [cell setIndexPath:indexPath rowsInSection:group.items.count];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    GroupModel *group = self.groups[section];
    return group.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    GroupModel *group = self.groups[section];
    return group.header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 1.取出这行对应的item模型
    GroupModel *group = self.groups[indexPath.section];
    ItemModel *item = group.items[indexPath.row];
    
    //如果有数字  选中之后不再显示数字
    if (item.badgeValue) {
        item.badgeValue = nil;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }
    
    // 2.判断有无需要跳转的控制器
    if (item.destVcClass) {
        UIViewController *destVc = [[item.destVcClass alloc] init];
        destVc.title = item.title;
        [self.navigationController pushViewController:destVc animated:YES];
    }
    
    // 3.判断有无想执行的操作
    if (item.operation) {
        item.operation();
    }
}

#pragma mark - SettingBaseCellDelegate

- (void)settingBaseCell:(SettingBaseCell *)settingBaseCell didClickSwitch:(UISwitch *)clickSwitch withItemModel:(SwitchItemModel *)switchItemModel{
    
}

@end
