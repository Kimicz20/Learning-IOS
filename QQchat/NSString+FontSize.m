//
//  NSString+FontSize.m
//  QQchat
//
//  Created by Geek on 16/5/18.
//  Copyright © 2016年 Geek. All rights reserved.
//

#import "NSString+FontSize.h"

@implementation NSString (FontSize)
/**
 * 计算文字尺寸
 *
 * @param text 需要计算尺寸的文字
 * @param font 文字的字体
 * @param maxSize 文字的最大尺寸
 */

+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs =@{NSFontAttributeName :font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
@end
