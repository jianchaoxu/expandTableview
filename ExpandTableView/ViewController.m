//
//  ViewController.m
//  ExpandTableView
//
//  Created by 易骏 on 17/4/26.
//  Copyright © 2017年 xjc. All rights reserved.
//

#import "ViewController.h"
#import "QuestionModel.h"
#import "QuestionCell.h"
#define DEVICE_WIDTH  [UIScreen mainScreen].bounds.size.width
#define DEVICE_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *expandTableView;

@property (nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation ViewController

-(void)layoutTableView
{
    self.expandTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_HEIGHT) style:UITableViewStylePlain];
    self.expandTableView.delegate = self;
    self.expandTableView.dataSource = self;
    self.expandTableView.tableFooterView = [UIView new];
    self.expandTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.expandTableView];
}

- (void)initData
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Questions" ofType:@"json"];
    NSString *jsonContent=[[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    if (jsonContent != nil)
    {
        NSData *jsonData = [jsonContent dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSMutableDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:&err];
        NSArray *textList = [dic objectForKey:@"Qustions"];
        for (NSDictionary *dict in textList)
        {
            QuestionModel *ques = [[QuestionModel alloc]initWithDict:dict];
            if (ques)
            {
                [self.dataArray addObject:ques];
            }
        }
        if(err) {
            NSLog(@"json解析失败：%@",err);
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"可展开的UITableView";
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = [NSMutableArray array];
    [self layoutTableView];
    [self initData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.tableFooterView = [[UIView alloc] init];
    static NSString *cellIdentifier = @"AssistanceCell";
    QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[QuestionCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    if ([self.dataArray count] > indexPath.row)
    {
        //这里的判断是为了防止数组越界
        cell.quesModel = [self.dataArray objectAtIndex:indexPath.row];
    }
    //自定义cell的回调，获取要展开/收起的cell。刷新点击的cell
    cell.showMoreTextBlock = ^(UITableViewCell *currentCell){
        NSIndexPath *indexRow = [self.expandTableView indexPathForCell:currentCell];
        [self.expandTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexRow, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionModel *model = nil;
    if ([self.dataArray count] > indexPath.row)
    {
        model = [self.dataArray objectAtIndex:indexPath.row];
    }
    
    //根据isShowMoreText属性判断cell的高度
    if (model.isShowMoreText)
    {
        return [QuestionCell cellMoreHeight:model];
    }
    else
    {
        return [QuestionCell cellDefaultHeight:model];
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
