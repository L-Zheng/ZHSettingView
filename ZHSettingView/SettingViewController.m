//
//  SettingViewController.m
//  ZHSettingView
//
//  Created by 李保征 on 2018/2/12.
//  Copyright © 2018年 李保征. All rights reserved.
//

#import "SettingViewController.h"
#import "TempViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:211.0/255.0 green:211.0/255.0 blue:211.0/255.0 alpha:1.0];
    [self setupGroups];
}


- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup2];
}

- (void)setupGroup0
{
    // 1.创建组
    GroupModel *group = [GroupModel group];
    [self.groups addObject:group];
    
    // 2.设置组的基本数据
    group.header = @"第0组头部";
    group.footer = @"第0组尾部的详细信息";
    
    // 3.设置组的所有行数据
    ItemModel *gameCenter = [ItemModel itemWithTitle:@"游戏中心" icon:@"game_center"];
    gameCenter.destVcClass = [TempViewController class];
    
    ArrowItemModel *hotStatus = [ArrowItemModel itemWithTitle:@"热门微博" icon:@"hot_status"];
    hotStatus.subtitle = @"笑话，娱乐，神最右都搬到这啦";
    hotStatus.destVcClass = [TempViewController class];
    
    ArrowItemModel *findPeople = [ArrowItemModel itemWithTitle:@"找人" icon:@"find_people"];
    findPeople.badgeValue = @"N";
    findPeople.destVcClass = [TempViewController class];
    findPeople.subtitle = @"名人、有意思的人尽在这里";
    
    SubLabelItemModel *near = [SubLabelItemModel itemWithTitle:@"周边" icon:@"near"];
    near.destVcClass = [TempViewController class];
    near.text = @"测试文字";
    
    group.items = @[gameCenter,hotStatus, findPeople,near];
}

- (void)setupGroup2
{
    // 1.创建组
    GroupModel *group = [GroupModel group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    SwitchItemModel *video = [SwitchItemModel itemWithTitle:@"视频" icon:@"video"];
    video.isSwitchOn = 1;
    video.operation = ^{
        NSLog(@"----点击了视频---");
    };
    
    SwitchItemModel *music = [SwitchItemModel itemWithTitle:@"音乐"];
    
    ItemModel *movie = [ItemModel itemWithTitle:@"电影" icon:@"movie"];
    movie.operation = ^{
        NSLog(@"----点击了电影");
    };
    
    SubLabelItemModel *cast = [SubLabelItemModel itemWithTitle:@"播客" icon:@"cast"];
    cast.operation = ^{
        NSLog(@"----点击了播客");
    };
    cast.badgeValue = @"5";
    cast.subtitle = @"(10)";
    cast.text = @"axxxx";
    
    ArrowItemModel *more = [ArrowItemModel itemWithTitle:@"更多" icon:@"more"];
    //    more.badgeValue = @"998";
    
    group.items = @[video, music, movie, cast, more];
}


@end
