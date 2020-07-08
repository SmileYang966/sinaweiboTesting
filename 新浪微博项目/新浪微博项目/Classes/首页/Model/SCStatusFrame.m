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
    
    //时间
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + IWStatusCellBorderW;
    CGSize timeSize = [self sizeWithText:status.created_at font:[UIFont systemFontOfSize:15.0f]];
    self.timeLabelF = CGRectMake(timeX, timeY, timeSize.width*1.5, timeSize.height);
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + IWStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:[UIFont systemFontOfSize:15.0f]];
    self.sourceLabelF =  CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    
    //正文
    CGFloat contentX = iconX;
    CGFloat contentY = CGRectGetMaxY(self.iconF) + IWStatusCellBorderW;
    CGFloat maxWidth = UIScreen.mainScreen.bounds.size.width - 2*IWStatusCellBorderW;
    CGSize contentSize = [status.text boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13.0f]} context:nil].size;
    self.contentLabelF = CGRectMake(contentX, contentY, contentSize.width, contentSize.height);
    
    
    //配图
    CGFloat originalH =0;
    if (status.pic_urls.count > 0) {//有配图
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF)+IWStatusCellBorderW;
        CGFloat photoWidth = 100;
        CGFloat photoHeight = 100;
        self.contentImageViewF = CGRectMake(photoX,photoY,photoWidth,photoHeight);
        
        originalH = CGRectGetMaxY(self.contentImageViewF) + IWStatusCellBorderW;
    }else{//无配图
        originalH = CGRectGetMaxY(self.contentLabelF) + IWStatusCellBorderW;
    }
    
    //原创微博整体
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = UIScreen.mainScreen.bounds.size.width;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    //被转发微博正文
    CGFloat retweetContentViewX = IWStatusCellBorderW;
    CGFloat retweetContentViewY = IWStatusCellBorderW;
    SCStatus *retweetStatus = status.retweeted_status;
    NSString *retweetContentLabelString = [NSString stringWithFormat:@"@%@ : %@",retweetStatus.user.name,retweetStatus.text];
    
    CGSize retweetContentSize = [retweetContentLabelString boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15.0f]} context:nil].size;
    self.retweetContentLabelF = CGRectMake(retweetContentViewX, retweetContentViewY, retweetContentSize.width, retweetContentSize.height);
    
    //被转发微博配图
    CGFloat retweetViewHeight = 0;
    if (retweetStatus.pic_urls.count>0) {
        CGFloat retweetViewWH = 100;
        CGFloat retweetViewPhotoX = IWStatusCellBorderW;
        CGFloat retweetViewPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + IWStatusCellBorderW;
        self.retweetPhotoViewF = CGRectMake(retweetViewPhotoX, retweetViewPhotoY, retweetViewWH, retweetViewWH);
        retweetViewHeight = CGRectGetMaxY(self.retweetPhotoViewF)+IWStatusCellBorderW;
    }else{
        retweetViewHeight = CGRectGetMaxY(self.retweetContentLabelF)+IWStatusCellBorderW;
    }
    
    //被转发微博整体
    CGFloat retweetViewX = 0;
    CGFloat retweetViewY = CGRectGetMaxY(self.originalViewF);
    CGFloat retweetViewW = UIScreen.mainScreen.bounds.size.width;
    self.retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewHeight);
    
    
//    if (status.retweeted_status) {
//        self.height = CGRectGetMaxY(self.retweetViewF) + IWStatusCellBorderW;
//    }else{
//        self.height = CGRectGetMaxY(self.originalViewF) + IWStatusCellBorderW;
//    }
    
    //工具条
    CGFloat toolbarX = 0;
    CGFloat toolBarY = 0;
    if (status.retweeted_status) {
        toolBarY = CGRectGetMaxY(self.retweetViewF);
    }else{
        toolBarY = CGRectGetMaxY(self.originalViewF);
    }
    CGFloat toolBarWidth = UIScreen.mainScreen.bounds.size.width;
    CGFloat toolBarHeight = 35.0f;
    
    self.toolBarF = CGRectMake(toolbarX, toolBarY, toolBarWidth, toolBarHeight);
    
    
    self.height = CGRectGetMaxY(self.toolBarF) + IWStatusCellBorderW;
}

@end
