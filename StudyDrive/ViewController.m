//
//  ViewController.m
//  StudyDrive
//
//  Created by WangJun on 16/10/13.
//  Copyright © 2016年 WangJun. All rights reserved.
//

#import "ViewController.h"
#import "SelectView.h"
#import "FirstViewController.h"
#import "SubjectTwoViewController.h"
#import "WebViewController.h"

@interface ViewController ()
{
    SelectView * _selectView;
    
    __weak IBOutlet UIButton *selectBtn;
}
@end

@implementation ViewController
- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 100:// 车型选择
        {
            [UIView animateWithDuration:0.3 animations:^{
                _selectView.alpha = 1;
            }];
        }
            break;
        case 101:// 科目一
        {
            [self.navigationController pushViewController:[[FirstViewController alloc]init] animated:YES];
        }
            break;
        case 102:
        {
            [self.navigationController pushViewController:[[SubjectTwoViewController alloc]init] animated:YES];
        }
            break;
        case 103:
        {
            
        }
            break;
        case 104:
        {
            
        }
            break;
        case 105:
        {
            [self.navigationController pushViewController:[[WebViewController alloc]initWithUrl:@"http://zhinan.jxedt.com/index_7_1.htm"] animated:YES];
        }
            break;
        case 106:
        {
            [self.navigationController pushViewController:[[WebViewController alloc]initWithUrl:@"http://zhinan.jxedt.com/index_34_1.htm"] animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
    item.title = @"";
    self.navigationItem.backBarButtonItem = item;

    _selectView = [[SelectView alloc]initWithFrame:self.view.frame andBtn:selectBtn];
    _selectView.alpha = 0;
    [self.view addSubview:_selectView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
