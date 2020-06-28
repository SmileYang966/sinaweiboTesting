//
//  SCUser.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/14.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "SCUser.h"

@implementation SCUser

- (void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    if (_mbtype > 2) {
        self.isVip = true;
    }
}

@end
