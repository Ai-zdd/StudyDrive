//
//  SelectModelView.h
//  StudyDrive
//
//  Created by WangJun on 16/10/16.
//  Copyright © 2016年 WangJun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    testModel,
    lookingModel
}SelectModl;
typedef void (^SelectTouch)(SelectModl selectModel);
@interface SelectModelView : UIView
@property(nonatomic, assign)SelectModl selectModel;
- (SelectModelView *)initWithFrame: (CGRect)frame addTouch: (SelectTouch)touch;
@end
