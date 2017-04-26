//
//  QuestionCell.m
//  ExpandTableView
//
//  Created by 易骏 on 17/4/26.
//  Copyright © 2017年 xjc. All rights reserved.
//

#import "QuestionCell.h"
#import "Helper.h"
#define DEVICE_WIDTH  [UIScreen mainScreen].bounds.size.width
#define  Color(r, g, b )     [UIColor colorWithRed:r/255.0 green:g/255.0f blue:b/255.0f alpha:1.0f]

@interface QuestionCell ()
{
    UILabel      *_textTitle;
    UILabel      *_textContent;
    UIButton     *_moreTextBtn;
}
@end

@implementation QuestionCell
+ (CGFloat)cellDefaultHeight:(QuestionModel *)quest;
{
    //默认cell高度
    return 60.0;
}

+(CGFloat)cellMoreHeight:(QuestionModel *)quest;
{
    //展开后得高度(计算出文本内容的高度+固定控件的高度)
        return [Helper stringBoundSizeWithConten:quest.textContent fontSize:16].height + 65;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
-(void)createUI
{
    _textTitle = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, DEVICE_WIDTH-50, 50)];
    _textTitle.textAlignment = NSTextAlignmentLeft;
    _textTitle.font = [UIFont systemFontOfSize:12];
    _textTitle.numberOfLines = 0;
    [self.contentView addSubview:_textTitle];
    
    _textContent = [[UILabel alloc]initWithFrame:CGRectZero];
    _textContent.textColor = [UIColor blackColor];
    _textContent.font = [UIFont fontWithName:@"Helvetica-LightOblique" size:14];
    //  _textContent.font = [UIFont systemFontOfSize:14];
    _textContent.numberOfLines = 0;
    [self.contentView addSubview:_textContent];
    
    
    
    _moreTextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreTextBtn.backgroundColor = [UIColor clearColor];
    _moreTextBtn.frame = CGRectMake(0, 0, DEVICE_WIDTH, 60);
    [self.contentView addSubview:_moreTextBtn];
    [_moreTextBtn addTarget:self action:@selector(showMoreText) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _textTitle.text   = self.quesModel.textName;
    _textContent.text = self.quesModel.textContent;
    if (self.quesModel.isShowMoreText)
    {
        ///计算文本高度
        
        /**
         
         *   NSStringDrawingUsesLineFragmentOrigin = 1 << 0,
         整个文本将以每行组成的矩形为单位计算整个文本的尺寸
         The specified origin is the line fragment origin, not the base line origin
         *   NSStringDrawingUsesFontLeading = 1 << 1,
         使用字体的行间距来计算文本占用的范围，即每一行的底部到下一行的底部的距离计算
         Uses the font leading for calculating line heights
         *   NSStringDrawingUsesDeviceMetrics = 1 << 3,
         将文字以图像符号计算文本占用范围，而不是以字符计算。也即是以每一个字体所占用的空间来计算文本范围
         Uses image glyph bounds instead of typographic bounds
         *   NSStringDrawingTruncatesLastVisibleLine
         当文本不能适合的放进指定的边界之内，则自动在最后一行添加省略符号。如果NSStringDrawingUsesLineFragmentOrigin没有设置，则该选项不生效
         Truncates and adds the ellipsis character to the last visible line if the text doesn't fit into the bounds specified.
         */
        
        [_textContent setFrame:CGRectMake(25, 60, DEVICE_WIDTH - 50, [Helper stringBoundSizeWithConten:self.quesModel.textContent fontSize:14].height+10)];
        } else {
        [_textContent setFrame:CGRectZero];
    }
    
}

- (void)showMoreText
{
    //将当前对象的isShowMoreText属性设为相反值
    self.quesModel.isShowMoreText = !self.quesModel.isShowMoreText;
    if (self.showMoreTextBlock) {
        self.showMoreTextBlock(self);
    }
}

-(void)drawRect:(CGRect)rect
{
    //创建路径并获取句柄
    CGMutablePathRef path = CGPathCreateMutable();
    
    //指定矩形
    CGRect rectangle = CGRectMake(15, 5, DEVICE_WIDTH-30, 50);
    
    //将矩形添加到路径中
    CGPathAddRect(path,NULL, rectangle);
    
    //获取上下文
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    //将路径添加到上下文
    CGContextAddPath(currentContext, path);
    
    //设置矩形填充色
    [Color(245, 248, 250) setFill];
    
    //矩形边框颜色
    [Color(237, 241, 242) setStroke];
    
    //边框宽度
    CGContextSetLineWidth(currentContext,1.0f);
    
    //绘制
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    
    CGPathRelease(path);
    
}


@end
