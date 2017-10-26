//
//  AnswerViewController.h
//  StudyDrive
//
//  Created by WangJun on 16/10/14.
//  Copyright © 2016年 WangJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerViewController : UIViewController
@property(nonatomic,assign)int number;// 章节练习中 章节号
@property(nonatomic, copy)NSString *subStrNumber;
// type=1 章节练习 type=2 顺序练习 type=3 随机练习 type=4 专项练习 type=5 模拟考试（全真）type=6 先做未答 type=7 我的错题 type=8 我的收藏
@property(nonatomic,assign)int type;
@end
