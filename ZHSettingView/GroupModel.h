//
//  GroupModel.h
//  ZHSettingView
//
//  Created by 李保征 on 2018/2/12.
//  Copyright © 2018年 李保征. All rights reserved.
//
//  用一个GroupModel模型来描述每组的信息：组头、组尾、这组的所有行模型

#import <Foundation/Foundation.h>
#import "ItemModel.h"

@interface GroupModel : NSObject
/** 组头 */
@property (nonatomic, copy) NSString *header;
/** 组尾 */
@property (nonatomic, copy) NSString *footer;
/** 这组的所有行模型(数组中存放的都是ItemModel模型) */
@property (nonatomic, strong) NSArray <ItemModel *> *items;

+ (instancetype)group;

@end
