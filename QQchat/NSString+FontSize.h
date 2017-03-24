//
//  NSString+FontSize.h
//  QQchat
//
//  Created by Geek on 16/5/18.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (FontSize)

+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
@end
