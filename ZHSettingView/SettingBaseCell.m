//
//  SettingBaseCell.m
//  ZHSettingView
//
//  Created by 李保征 on 2018/2/12.
//  Copyright © 2018年 李保征. All rights reserved.
//

#import "SettingBaseCell.h"
#import "BadgeIconView.h"

@interface SettingBaseCell()

@property (strong, nonatomic) UIImageView *rightArrow;

@property (strong, nonatomic) UISwitch *rightSwitch;

@property (strong, nonatomic) UILabel *rightLabel;

@property (strong, nonatomic) BadgeIconView *bageView;

@end

@implementation SettingBaseCell

#pragma mark - init

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    NSString *SettingBaseCellID = @"SettingBaseCellID";
    SettingBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:SettingBaseCellID];
    if (!cell) {
        cell = [[SettingBaseCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SettingBaseCellID];
    }
    return cell;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 设置标题的字体
        self.textLabel.font = [UIFont boldSystemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
        
        // 去除cell的默认背景色
//        self.backgroundColor = [UIColor clearColor];
        
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
    }
    return self;
}

#pragma mark - getter
- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        self.rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UISwitch *)rightSwitch
{
    if (_rightSwitch == nil) {
        self.rightSwitch = [[UISwitch alloc] init];
        [_rightSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _rightSwitch;
}

- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        self.rightLabel = [[UILabel alloc] init];
        self.rightLabel.textColor = [UIColor lightGrayColor];
        self.rightLabel.font = [UIFont systemFontOfSize:13];
    }
    return _rightLabel;
}

- (BadgeIconView *)bageView
{
    if (_bageView == nil) {
        self.bageView = [[BadgeIconView alloc] init];
    }
    return _bageView;
}

#pragma mark - setter

- (void)setItem:(ItemModel *)item{
    _item = item;
    // 1.设置基本数据
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    
    //设置选中风格
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    // 2.设置右边的内容
    if (item.badgeValue) { // 紧急情况：右边有提醒数字
        self.bageView.badgeValue = item.badgeValue;
        self.accessoryView = self.bageView;
    } else if ([item isKindOfClass:[ArrowItemModel class]]) {
        self.accessoryView = self.rightArrow;
    } else if ([item isKindOfClass:[SwitchItemModel class]]) {
        SwitchItemModel *switchItem = (SwitchItemModel *)item;
        //重新设置开关状态  否则出现重用
        self.rightSwitch.on = switchItem.isSwitchOn;
        self.accessoryView = self.rightSwitch;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if ([item isKindOfClass:[SubLabelItemModel class]]) {
        SubLabelItemModel *labelItem = (SubLabelItemModel *)item;
        // 设置文字
        self.rightLabel.text = labelItem.text;
        // 根据文字计算尺寸
        CGRect frame = self.rightLabel.frame;
        frame.size = [labelItem.text sizeWithFont:self.rightLabel.font];
        self.rightLabel.frame = frame;
        self.accessoryView = self.rightLabel;
    } else { // 取消右边的内容
        self.accessoryView = nil;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

#pragma mark - data

#pragma mark - action
- (void)switchValueChanged:(UISwitch *)mySwitch{
    SwitchItemModel *switchItem = (SwitchItemModel *)self.item;
    switchItem.isSwitchOn = mySwitch.on;
    if ([switchItem.title isEqualToString:@"是否推送"]) {
        //执行存储操作或其他操作
    }
    
    if ([_delegate respondsToSelector:@selector(settingBaseCell:didClickSwitch:withItemModel:)]) {
        [_delegate settingBaseCell:self didClickSwitch:mySwitch withItemModel:switchItem];
    }
}

#pragma mark - public

#pragma mark - delegate

#pragma mark - layout

- (void)layoutSubviews{
    [super layoutSubviews];
    // 调整子标题的x
    CGRect frame = self.detailTextLabel.frame;
    frame.origin.x = CGRectGetMaxX(self.textLabel.frame) + 10;
    self.detailTextLabel.frame = frame;
}

#pragma mark - other

@end
