//
//  SCHomeTableViewCell.h
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/21.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@class SCStatusFrame;
@interface SCHomeTableViewCell : UITableViewCell

+(instancetype)cellwithTableView:(UITableView *)tableView;

@property(nonatomic,strong) SCStatusFrame *statusFrame;

@end

NS_ASSUME_NONNULL_END
