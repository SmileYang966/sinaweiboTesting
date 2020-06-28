//
//  SCStatusFrame.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/21.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "SCStatusFrame.h"
#import "SCStatus.h"
#import "SCUser.h"

#define IWStatusCellBorderW 10

@implementation SCStatusFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = font;
    return [text sizeWithAttributes:attr];
}

- (void)setStatus:(SCStatus *)status{
    _status = status;
    SCUser *user = status.user;
    
    //原创微博
    
    //头像
    CGFloat iconWH = 50;
    CGFloat iconX = IWStatusCellBorderW;
    CGFloat iconY = IWStatusCellBorderW;
    self.iconF = CGRectMake(iconX,iconY,iconWH,iconWH);
        
    //昵称
    CGFloat nameX = CGRectGetMaxX(self.iconF) + IWStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self  sizeWithText:user.name font:[UIFont systemFontOfSize:15.0f]];
    self.nameLabelF = CGRectMake(nameX,nameY,nameSize.width,nameSize.height);
    
    //会员图标
    if (status.user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + IWStatusCellBorderW;
        CGFloat vipY = iconY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
}

@end
