//
//  Helper.m
//  ExpandTableView
//
//  Created by 易骏 on 17/4/26.
//  Copyright © 2017年 xjc. All rights reserved.
//

#import "Helper.h"
#define DEVICE_WIDTH  [UIScreen mainScreen].bounds.size.width
@implementation Helper

+(CGSize)stringBoundSizeWithConten:(NSString *)content fontSize:(CGFloat)fontSize
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont fontWithName:@"Helvetica-LightOblique" size:fontSize]};
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [content boundingRectWithSize:CGSizeMake(DEVICE_WIDTH - 30, 100000) options:option attributes:attribute context:nil].size;
    return size;
}
@end
