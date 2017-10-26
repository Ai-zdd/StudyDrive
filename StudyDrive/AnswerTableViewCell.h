//
//  AnswerTableViewCell.h
//  StudyDrive
//
//  Created by WangJun on 16/10/14.
//  Copyright © 2016年 WangJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIImageView *numberImage;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;

@end
