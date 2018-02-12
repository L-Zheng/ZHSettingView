//
//  SettingBaseViewController.h
//  ZHSettingView
//
//  Created by 李保征 on 2018/2/12.
//  Copyright © 2018年 李保征. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GroupModel.h"
#import "ArrowItemModel.h"
#import "SubLabelItemModel.h"
#import "SwitchItemModel.h"

@interface SettingBaseViewController : UIViewController

@property (nonatomic, strong) NSMutableArray <GroupModel *> *groups;

@end
