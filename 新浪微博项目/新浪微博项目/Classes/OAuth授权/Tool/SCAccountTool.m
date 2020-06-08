//
//  SCAccountTool.m
//  新浪微博项目
//
//  Created by Evan Yang on 2020/6/9.
//  Copyright © 2020 Evan Yang. All rights reserved.
//

#import "SCAccountTool.h"

@class AccountModel;

@implementation SCAccountTool

+(void)saveAccount:(AccountModel *)account{
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
     NSString *filePath = [docDirPath stringByAppendingPathComponent:@"account.archive"];
     [NSKeyedArchiver archiveRootObject:account toFile:filePath];
}

+(AccountModel *)fetchAccount{
    NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filePath = [docDirPath stringByAppendingPathComponent:@"account.archive"];
    AccountModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return account;
}

@end
