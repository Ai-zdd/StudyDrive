//
//  MainTestViewController.m
//  StudyDrive
//
//  Created by WangJun on 16/10/18.
//  Copyright © 2016年 WangJun. All rights reserved.
//

#import "MainTestViewController.h"
#import "AnswerViewController.h"

@interface MainTestViewController ()
@property (weak, nonatomic) IBOutlet UIButton *buttonA;
@property (weak, nonatomic) IBOutlet UIButton *buttonB;

@end

@implementation MainTestViewController
- (IBAction)clickBtn:(UIButton *)sender {
    switch (sender.tag) {
        case 201:
        {
            AnswerViewController *con = [[AnswerViewController alloc]init];
            con.type = 5;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 202:
        {
            
        }
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"仿真模拟考试";
    _buttonA.layer.masksToBounds = YES;
    _buttonA.layer.cornerRadius = 8;
    _buttonB.layer.masksToBounds = YES;
    _buttonB.layer.cornerRadius = 8;
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
