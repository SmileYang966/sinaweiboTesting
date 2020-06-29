//
//  SCHomeTableViewCell.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/21.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "SCHomeTableViewCell.h"
#import "SCStatusFrame.h"
#import "SCStatus.h"
#import "SCUser.h"
#import "UIImageView+WebCache.h"

@interface SCHomeTableViewCell()

/**原创微博整体*/
@property(nonatomic,strong)UIView *originalView;

/**图标*/
@property(nonatomic,strong)UIImageView *icon;

/**微博名称*/
@property(nonatomic,strong)UILabel *nameLabel;

/**是否是vip，如果是显示vip标示*/
@property(nonatomic,strong)UIImageView *vipView;

/**微博发送时间label*/
@property(nonatomic,strong)UILabel *timeLabel;

/**微博来源label*/
@property(nonatomic,strong)UILabel *sourceLabel;

/**正文*/
@property(nonatomic,strong)UILabel *contentLabel;

/**正文的imageView*/
@property(nonatomic,strong)UIImageView *contentImageView;


/*转载微博整体*/


/*评论区整体*/

@end

@implementation SCHomeTableViewCell

+ (instancetype)cellwithTableView:(UITableView *)tableView{
    NSString *ID = @"cellID";
    SCHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SCHomeTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1.原创微博整体
        self.originalView = [[UIView alloc]init];
//        self.originalView.backgroundColor = UIColor.redColor;
        [self addSubview:self.originalView];
        
        //图标
        self.icon = [[UIImageView alloc]init];
        [self.originalView addSubview:self.icon];
        
        self.nameLabel = [[UILabel alloc]init];
        [self.originalView addSubview:self.nameLabel];

        /**是否是vip，如果是显示vip标示*/
        self.vipView = [[UIImageView alloc]init];
        self.vipView.contentMode = UIViewContentModeCenter;
        [self.originalView addSubview:self.vipView];

        /**微博发送时间label*/
        self.timeLabel = [[UILabel alloc]init];
        self.timeLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.originalView addSubview:self.timeLabel];

        /**微博来源label*/
        self.sourceLabel = [[UILabel alloc]init];
        self.sourceLabel.font = [UIFont systemFontOfSize:15.0f];
        [self.originalView addSubview:self.sourceLabel];

        /**正文*/
        self.contentLabel = [[UILabel alloc]init];
        self.contentLabel.font = [UIFont systemFontOfSize:13.0f];
        self.contentLabel.numberOfLines = 0;
        [self.originalView addSubview:self.contentLabel];

        /**正文的imageView*/
        self.contentImageView = [[UIImageView alloc]init];
        [self.originalView addSubview:self.contentImageView];
    }
    return self;
}

- (void)setStatusFrame:(SCStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    SCStatus *status = statusFrame.status;
    SCUser *user = status.user;
    
    self.originalView.frame = statusFrame.originalViewF;
    
    
    //Icon frame
    self.icon.frame = statusFrame.iconF;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    //name
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.font = [UIFont systemFontOfSize:15.0f];
    self.nameLabel.backgroundColor = UIColor.redColor;
    self.nameLabel.text = user.name;
    
    //vip
    self.vipView.frame = statusFrame.vipViewF;
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        ;
    }else{
        self.vipView.hidden = YES;
    }
    
    //time label
    self.timeLabel.frame = statusFrame.timeLabelF;
    self.timeLabel.text = status.created_at;
    
    //source label
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    self.sourceLabel.text = status.source;
    
    //content label
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    
    //content imageview
    self.contentImageView.frame = statusFrame.contentImageViewF;
}

@end
