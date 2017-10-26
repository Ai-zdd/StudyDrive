//
//  SheetView.h
//  StudyDrive
//
//  Created by WangJun on 16/10/16.
//  Copyright © 2016年 WangJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SheetViewDelegate
- (void)SheetViewClick:(int)index;
@end

@interface SheetView : UIView
{
    @public
    UIView *_backView;
}
@property(nonatomic, weak)id<SheetViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withSuperView: (UIView *)superView andQuestionCount: (int)count;
@end
