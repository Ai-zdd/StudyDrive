//
//  TestSelectViewController.h
//  StudyDrive
//  章节练习选题界面
//  Created by WangJun on 16/10/14.
//  Copyright © 2016年 WangJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestSelectViewController : UIViewController
@property(nonatomic, copy) NSString * myTitle;
@property(nonatomic, copy) NSArray * dataArray;
// type=1章节 type=2专项
@property(nonatomic, assign)int type;
@end
