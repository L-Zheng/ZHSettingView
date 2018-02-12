//
//  SettingBaseCell.h
//  ZHSettingView
//
//  Created by 李保征 on 2018/2/12.
//  Copyright © 2018年 李保征. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemModel.h"
#import "ArrowItemModel.h"
#import "SubLabelItemModel.h"
#import "SwitchItemModel.h"
@class SettingBaseCell;

@protocol SettingBaseCellDelegate <NSObject>

- (void)settingBaseCell:(SettingBaseCell *)settingBaseCell didClickSwitch:(UISwitch *)clickSwitch withItemModel:(SwitchItemModel *)switchItemModel;

@end

@interface SettingBaseCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) ItemModel *item;

@property (nonatomic, weak) id <SettingBaseCellDelegate> delegate;

@end
