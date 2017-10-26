//
//  Tools.h
//  StudyDrive
//
//  Created by WangJun on 16/10/14.
//  Copyright © 2016年 WangJun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Tools : NSObject
+ (NSArray *)getAnswerWithString: (NSString *)str;
+ (CGSize)getSizeWithString: (NSString *)str withFone: (UIFont *)font withSize: (CGSize)size;
@end
