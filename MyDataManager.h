//
//  MyDataManager.h
//  StudyDrive
//
//  Created by WangJun on 16/10/14.
//  Copyright © 2016年 WangJun. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    chapter,// 章节练习数据
    answer,// 答题数据
    subChapter//专项练习数据
}DataType;
@interface MyDataManager : NSObject
+ (NSArray *)getData: (DataType)type;
@end
