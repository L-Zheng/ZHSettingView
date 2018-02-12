//
//  ItemModel.m
//  ZHSettingView
//
//  Created by 李保征 on 2018/2/12.
//  Copyright © 2018年 李保征. All rights reserved.
//

#import "ItemModel.h"

@implementation ItemModel

+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon{
    ItemModel *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title{
    return [self itemWithTitle:title icon:nil];
}

@end
