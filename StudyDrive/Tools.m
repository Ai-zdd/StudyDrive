//
//  Tools.m
//  StudyDrive
//
//  Created by WangJun on 16/10/14.
//  Copyright © 2016年 WangJun. All rights reserved.
//

#import "Tools.h"

@implementation Tools
+ (NSArray *)getAnswerWithString:(NSString *)str {
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSArray *arr = [str componentsSeparatedByString:@"<BR>"];
    [array addObject:arr[0]];
    for (int i=0; i<4; i++) {
        [array addObject:[arr[i+1] substringFromIndex:2]];
    }
    return array;
}

+ (CGSize)getSizeWithString:(NSString *)str withFone:(UIFont *)font withSize:(CGSize)size {
    //CGSize newSize = [str sizeWithFont:font constrainedToSize:size];
    NSDictionary *att = @{NSFontAttributeName: font};
    CGSize newSize = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil].size;
    return newSize;
}
@end
