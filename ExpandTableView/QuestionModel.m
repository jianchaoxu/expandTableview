//
//  QuestionModel.m
//  ExpandTableView
//
//  Created by 易骏 on 17/4/26.
//  Copyright © 2017年 xjc. All rights reserved.
//

#import "QuestionModel.h"

@implementation QuestionModel
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self)
    {
        self.textId         = [[dict objectForKey:@"NO"] intValue];
        self.textName       = [dict objectForKey:@"title"];
        self.textContent    = [dict objectForKey:@"ans"];
        self.isShowMoreText =  NO;
    }
    return self;
}
@end
