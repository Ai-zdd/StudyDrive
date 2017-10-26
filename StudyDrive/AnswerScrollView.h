//
//  AnswerScrollView.h
//  StudyDrive
//
//  Created by WangJun on 16/10/14.
//  Copyright © 2016年 WangJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerScrollView : UIView
{
    @public
    UIScrollView *_scrollView;
}
@property(nonatomic, assign, readonly)int currentPage;
@property(nonatomic, strong)NSMutableArray *hadAnswerArray;//被答过的题(0：未答 1:A ...)
@property(nonatomic, strong)NSArray *dataArray;

- (instancetype)initWithFrame: (CGRect)frame withDataArray: (NSArray *)array;
- (void)reloadData;
@end
