//
//  AnswerViewController.m
//  StudyDrive
//  核心答题界面
//  Created by WangJun on 16/10/14.
//  Copyright © 2016年 WangJun. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerScrollView.h"
#import "MyDataManager.h"
#import "AnswerModel.h"
#import "SelectModelView.h"
#import "SheetView.h"
#import "QuestionCollectManager.h"

@interface AnswerViewController ()<SheetViewDelegate>
{
    AnswerScrollView *_answerScrollView;
    SelectModelView *_modelView;
    SheetView *_sheetView;
    NSTimer *_timer;
    UILabel *_timeLabel;
}
@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createSelectModelView];
    [self createData];
    [self.view addSubview:_answerScrollView];
    [self createSheetView];
}

- (void)createData {
    if (_type==1) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        NSArray *array = [MyDataManager getData:answer];
        
        for (int i=0; i<array.count-1; i++) {
            AnswerModel *model = array[i];
            if ([model.pid intValue]==_number+1) {
                [arr addObject:model];
            }
        }
        
        _answerScrollView = [[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:arr];
        
    }else if(_type==2) {
        
        _answerScrollView = [[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:[MyDataManager getData:answer]];
        
    }else if(_type==3) {
        
        NSMutableArray *tmpArr = [[NSMutableArray alloc]init];
        NSArray *array = [MyDataManager getData:answer];
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        [tmpArr addObjectsFromArray:array];
        
        for (int i=0; i<tmpArr.count; ) {
            int index = arc4random()%tmpArr.count;
            [dataArray addObject:tmpArr[index]];
            [tmpArr removeObjectAtIndex:index];
        }
        
        _answerScrollView = [[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:dataArray];
    }else if(_type==4) {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        NSArray *array = [MyDataManager getData:answer];
        
        for (int i=0; i<array.count-1; i++) {
            AnswerModel *model = array[i];
            if ([model.sid isEqualToString:_subStrNumber]) {
                [arr addObject:model];
            }
        }
        
        _answerScrollView = [[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:arr];
    }else if (_type==5) {
        NSMutableArray *tmpArr = [[NSMutableArray alloc]init];
        NSArray *array = [MyDataManager getData:answer];
        NSMutableArray *dataArray = [[NSMutableArray alloc]init];
        [tmpArr addObjectsFromArray:array];
        
        for (int i=0; i<100; i++) {
            int index = arc4random()%tmpArr.count;
            [dataArray addObject:tmpArr[index]];
            [tmpArr removeObjectAtIndex:index];
        }
        
        _answerScrollView = [[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:dataArray];
        
        [self createNaviBtn];
    }
    
    if (_type==7) {
        //读取错题
        NSMutableArray *tmpArr = [[NSMutableArray alloc]init];

        NSArray *array = [MyDataManager getData:answer];
        
        NSArray *wrongArray = [QuestionCollectManager getWrongQuestion];
        
        for (AnswerModel *model in array) {
            for (NSString *num in wrongArray) {
                if ([num isEqualToString:model.mid]) {
                    [tmpArr addObject:model];
                }
            }
        }
        
        if (tmpArr.count!=0) {
            _answerScrollView = [[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:tmpArr];
        }
    }
    
    if (_type==8) {
        //读取收藏
        NSMutableArray *tmpArr = [[NSMutableArray alloc]init];
        NSArray *array = [MyDataManager getData:answer];
        NSArray *collectArray = [QuestionCollectManager getCollectQuestion];
        
        for (AnswerModel *model in array) {
            for (NSString *num in collectArray) {
                if ([num isEqualToString:model.mid]) {
                    [tmpArr addObject:model];
                }
            }
        }
        
        if (tmpArr.count!=0) {
            _answerScrollView = [[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64-60) withDataArray:tmpArr];
        }
    }
    
    if (_type!=5 && _type!=6) {
        [self createToolBar];
    }else {
        [self createTestToolBar];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTime) userInfo:nil repeats:YES];
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 64)];
        _timeLabel.text = @"45:00";
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = _timeLabel;
    }
}

- (void)runTime {
    static int Time = 2700;
    Time--;
    _timeLabel.text = [NSString stringWithFormat:@"%d:%d", Time/60, Time%60];
}

- (void)createNaviBtn {
    UIBarButtonItem *itemLeft = [[UIBarButtonItem alloc]init];
    itemLeft.title = @"返回";
    [itemLeft setTarget:self];
    [itemLeft setAction:@selector(clickNaviReturnBtn)];
    
    self.navigationItem.leftBarButtonItem = itemLeft;
    
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc]init];
    itemRight.title = @"交卷";
    [itemRight setTarget:self];
    [itemRight setAction:@selector(clickNaviRightBtn)];
    
    self.navigationItem.rightBarButtonItem = itemRight;
}

- (void)clickNaviRightBtn {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"时间还多，确定离开考试？" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"不，谢谢" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cancelButtonPushed];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"我要交卷" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self otherButtonPushed];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)clickNaviReturnBtn {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"时间还多，确定离开考试？" preferredStyle:UIAlertControllerStyleAlert];

    [alertController addAction:[UIAlertAction actionWithTitle:@"不，谢谢" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cancelButtonPushed];
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"我要离开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self otherButtonPushed];
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)cancelButtonPushed {
    
}

- (void)otherButtonPushed {
    // todo 做交卷处理
    int sorce = 0;
    NSArray *myAnswerArray = _answerScrollView.hadAnswerArray;
    NSArray *answerArray = _answerScrollView.dataArray;
    for (int i=0; i<myAnswerArray.count; i++) {
        // todo 做题目类型判断
        AnswerModel *model = answerArray[i];
        NSString *answerStr = model.manswer;
        NSString *myAnswerStr = [NSString stringWithFormat:@"%c", 'A'-1+[myAnswerArray[i] intValue]];
        if ([myAnswerStr isEqualToString:answerStr]) {
            sorce++;
        }
    }
    [QuestionCollectManager setMySorce:sorce];
    NSLog(@"%d", sorce);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createSheetView {
    _sheetView = [[SheetView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-80) withSuperView:self.view andQuestionCount:(int)_answerScrollView.dataArray.count];
    _sheetView.delegate = self;
    [self.view addSubview:_sheetView];
}

#pragma mark - _sheetView delegate
- (void)SheetViewClick:(int)index {
    UIScrollView *scroll = _answerScrollView -> _scrollView;
    scroll.contentOffset = CGPointMake((index-1)*scroll.frame.size.width, 0);
    [scroll.delegate scrollViewDidEndDecelerating:scroll];
}

- (void)createSelectModelView {
    _modelView = [[SelectModelView alloc]initWithFrame:self.view.frame addTouch:^(SelectModl selectModel) {
        NSLog(@"当前模式：%d", selectModel);
    }];
    [self.view addSubview:_modelView];
    _modelView.alpha = 0;
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"答题模式" style:UIBarButtonItemStylePlain target:self action:@selector(modelChange:)];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)modelChange: (UIBarButtonItem *)item {
    [UIView animateWithDuration:0.3 animations:^{
        _modelView.alpha = 1;
    }];
}

- (void)createToolBar {
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-64-60, self.view.frame.size.width, 60)];
    barView.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[[NSString stringWithFormat:@"%d", (int)_answerScrollView.dataArray.count], @"查看答案", @"收藏本题"];
    for (int i=0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.view.frame.size.width/3*i+self.view.frame.size.width/3/2-22, 0, 36, 36);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", 16+i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2.png", 16+i]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(clickToolBar:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 301+i;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(btn.center.x-30, 40, 60, 18)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = arr[i];
        label.font = [UIFont systemFontOfSize:14];
        [barView addSubview:btn];
        [barView addSubview:label];
    }
    [self.view addSubview:barView];
}

- (void)createTestToolBar {
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-64-60, self.view.frame.size.width, 60)];
    barView.backgroundColor = [UIColor whiteColor];
    NSArray *arr = @[[NSString stringWithFormat:@"%d", (int)_answerScrollView.dataArray.count], @"收藏本题"];
    for (int i=0; i<2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.view.frame.size.width/2*i+self.view.frame.size.width/2/2-22, 0, 36, 36);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", 16+i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2.png", 16+i]] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(clickToolBar:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 301+i;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(btn.center.x-30, 40, 60, 18)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = arr[i];
        label.font = [UIFont systemFontOfSize:14];
        [barView addSubview:btn];
        [barView addSubview:label];
    }
    [self.view addSubview:barView];
}

- (void)clickToolBar: (UIButton *)btn {
    switch (btn.tag) {
        case 301:
        {
            [UIView animateWithDuration:0.3 animations:^{
                _sheetView.frame = CGRectMake(0, 80, self.view.frame.size.width, self.view.frame.size.height-80);
                _sheetView->_backView.alpha = 0.8;
            }];
        }
            break;
        case 302:// 查看答案
        {
            if (_type!=5&&_type!=6) {
                if ([_answerScrollView.hadAnswerArray[_answerScrollView.currentPage] intValue]!=0) {// 题已答过
                    return;
                }else {
                    AnswerModel *model = [_answerScrollView.dataArray objectAtIndex:_answerScrollView.currentPage];
                    NSString *answer = model.manswer;
                    char an = [answer characterAtIndex:0];
                    [_answerScrollView.hadAnswerArray replaceObjectAtIndex:_answerScrollView.currentPage withObject:[NSString stringWithFormat:@"%d", an-'A'+1]];
                    [_answerScrollView reloadData];
                }
            }
        }
            break;
        case 303:// 收藏
        {
            AnswerModel *model = _answerScrollView.dataArray[_answerScrollView.currentPage];
            [QuestionCollectManager addCollectQuestion:[model.mid intValue]];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
