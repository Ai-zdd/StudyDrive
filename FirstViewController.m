//
//  FirstViewController.m
//  StudyDrive
//  科目一
//  Created by WangJun on 16/10/13.
//  Copyright © 2016年 WangJun. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstTableViewCell.h"
#import "TestSelectViewController.h"
#import "MyDataManager.h"
#import "AnswerViewController.h"
#import "MainTestViewController.h"
#import "QuestionCollectManager.h"

@interface FirstViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView * _tableView;
    NSArray * _dataArray;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"科目一 理论考试";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = @[@"章节练习", @"顺序练习", @"随机练习", @"专项练习", @"仿真模拟考试"];
    [self createTableView];
    [self createView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)createView {
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height-64-140, 300, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"••••••••••我的考试分析••••••••••";
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    NSArray * arr = @[@"我的错题", @"我的收藏", @"我的成绩", @"练习统计"];
    for (int i=0; i<4; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(self.view.frame.size.width/4*i+self.view.frame.size.width/4/2-30, self.view.frame.size.height-64-100, 60, 60);
        btn.tag = 201+i;
        [btn addTarget:self action:@selector(clickToolBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+12]] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        
        UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4*i+self.view.frame.size.width/4/2-30, self.view.frame.size.height-64-35, 60, 20)];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont boldSystemFontOfSize:13];
        lab.text = arr[i];
        [self.view addSubview:lab];
    }
}

- (void)clickToolBtn:(UIButton *)btn {
    NSLog(@"%d",(int)btn.tag);
    switch (btn.tag) {
        case 201:
        {
            AnswerViewController *answerView = [[AnswerViewController alloc]init];
            answerView.type = 7;
            answerView.title = @"我的错题";
            UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:answerView animated:YES];
        }
            break;
        case 202:
        {
            AnswerViewController *answerView = [[AnswerViewController alloc]init];
            answerView.type = 8;
            answerView.title = @"我的收藏";
            UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:answerView animated:YES];
        }
            break;
        case 203:
        {
            NSString *mySorce = [NSString stringWithFormat:@"最近一次的成绩为：%d", [QuestionCollectManager getMysorce]];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"我的成绩" message:mySorce preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self cancelButtonPushed];
            }]];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"查看错题" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self otherButtonPushed];
            }]];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
            break;
        default:
            break;
    }
}

- (void)cancelButtonPushed {
    
}

- (void)otherButtonPushed {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellID = @"FirstTableViewCell";
    
    FirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.myImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png", indexPath.row+7]];
    cell.myLabel.text = _dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:// 章节练习
        {
            TestSelectViewController *con = [[TestSelectViewController alloc]init];
            con.dataArray = [MyDataManager getData:chapter];
            con.type = 1;
            con.myTitle = @"章节练习";
            UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 1:// 顺序练习
        {
            AnswerViewController *answerView = [[AnswerViewController alloc]init];
            answerView.type = 2;
            answerView.title = @"顺序练习";
            UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:answerView animated:YES];
        }
            break;
        case 2:// 随机练习
        {
            AnswerViewController *answerView = [[AnswerViewController alloc]init];
            answerView.type = 3;
            answerView.title = @"随机练习";
            UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:answerView animated:YES];
        }
            break;
        case 3:// 专项练习
        {
            TestSelectViewController *con = [[TestSelectViewController alloc]init];
            con.dataArray = [MyDataManager getData:subChapter];
            con.type = 2;
            con.myTitle = @"专项练习";
            UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 4:// 模拟考试
        {
            MainTestViewController *con = [[MainTestViewController alloc]init];
            UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
            
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
