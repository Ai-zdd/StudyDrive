//
//  QuestionCollectManager.h
//  StudyDrive
//
//  Created by WangJun on 16/10/19.
//  Copyright © 2016年 WangJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionCollectManager : NSObject
+ (NSArray *)getWrongQuestion;
+ (void)addWrongQuestion:(int)mid;
+ (void)removeWrongQuestion:(int)mid;

+ (NSArray *)getCollectQuestion;
+ (void)addCollectQuestion:(int)mid;
+ (void)removeCollectQuestion:(int)mid;

+ (int)getMysorce;
+ (void)setMySorce:(int)sorce;
@end
