//
//  BadgeIconView.m
//  ZHSettingView
//
//  Created by 李保征 on 2018/2/12.
//  Copyright © 2018年 李保征. All rights reserved.
//

#import "BadgeIconView.h"

@implementation BadgeIconView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        UIImage *image = [UIImage imageNamed:@"main_badge"];
        UIImage *newImage = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
        [self setBackgroundImage:newImage forState:UIControlStateNormal];
        // 按钮的高度就是背景图片的高度
        CGRect frame = self.frame;
        frame.size.height = self.currentBackgroundImage.size.height;
        self.frame = frame;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    
    // 设置文字
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    // 根据文字计算自己的尺寸
    CGSize titleSize = [badgeValue sizeWithFont:self.titleLabel.font];
    CGFloat bgW = self.currentBackgroundImage.size.width;
    
    
    CGRect frame = self.frame;
    if (titleSize.width < bgW) {
        frame.size.width = bgW;
    } else {
        frame.size.width = titleSize.width + 10;
    }
    self.frame = frame;
}

@end
