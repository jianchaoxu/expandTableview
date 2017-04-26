//
//  QuestionModel.h
//  ExpandTableView
//
//  Created by 易骏 on 17/4/26.
//  Copyright © 2017年 xjc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionModel : NSObject
@property(nonatomic, assign)int       textId;

@property(nonatomic, strong)NSString  *textName;

@property(nonatomic, strong)NSString  *textContent;

@property(nonatomic, assign)BOOL      isShowMoreText;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
