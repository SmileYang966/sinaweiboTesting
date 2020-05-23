//
//  UIBarButtonItem+Extension.h
//  新浪微博项目
//
//  Created by Evan Yang on 2020/5/23.
//  Copyright © 2020 Evan Yang. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Extension)

+(UIBarButtonItem *)barButtonwithTarget:(id)target action:(SEL)action imageName:(NSString *)imageName selectedImageName:(NSString *)highlightedImage;

@end

NS_ASSUME_NONNULL_END
