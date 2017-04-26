//
//  QuestionCell.h
//  ExpandTableView
//
//  Created by 易骏 on 17/4/26.
//  Copyright © 2017年 xjc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionModel.h"
@interface QuestionCell : UITableViewCell

@property(nonatomic, strong)QuestionModel *quesModel;
///展开多个活动信息
@property(nonatomic, copy) void (^showMoreTextBlock)(UITableViewCell  *currentCell);

///未展开时的高度
+ (CGFloat)cellDefaultHeight:(QuestionModel *)quest;
///展开后的高度
+(CGFloat)cellMoreHeight:(QuestionModel *)quest;

@end
