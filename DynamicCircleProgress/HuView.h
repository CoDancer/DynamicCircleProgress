//
//  HuView.h
//  DynamicCircleProgress
//
//  Created by CoDancer on 16/12/8.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kScreenW [[UIScreen mainScreen] bounds].size.width

#define kScreenH [[UIScreen mainScreen] bounds].size.height
@interface HuView : UIView

@property(nonatomic,strong)UILabel *numLabel;
@property(nonatomic,strong)NSTimer *timer;

@property (nonatomic) BOOL repeatFlag;
@property (nonatomic, assign) int inputNum;
@property(nonatomic,assign)int num;

@end
