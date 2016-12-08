//
//  HuView.m
//  DynamicCircleProgress
//
//  Created by CoDancer on 16/12/8.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import "HuView.h"
#import "CircleAniView.h"

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0]
#define BGCOLOR RGB(59, 58, 81)
#define LINECOLOR RGB(135,255,185)
#define LINECOLOR1 RGB(255,150,241)

@interface HuView()

@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, strong) CircleAniView *circleView;

@end

@implementation HuView

- (void)drawRect:(CGRect)rect {
    //    仪表盘底部
    drawHu1();
    //    仪表盘进度
    [self drawHu2];
}

- (CircleAniView *)circleView {
    
    if (!_circleView) {
        _circleView =  [[CircleAniView alloc] initWithFrame:self.bounds];
        _circleView.percent = self.inputNum;
    }
    return _circleView;
}
-(void)drawHu2
{
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, 10);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换 ，实线2虚线8
    CGFloat length[] = {2,8};
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [self.lineColor set];
    
    //2.设置路径
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(numberChange:) name:@"number" object:nil];
    
    CGFloat end = -5*M_PI_4+(6*M_PI_4*_num/100);
    
    CGContextAddArc(ctx, kScreenW/2 , kScreenW/2, 95, -5*M_PI_4, end , 0);
    
    //3.绘制
    CGContextStrokePath(ctx);
}

-(void)numberChange:(NSNotification*)text
{
    _num = [text.userInfo[@"num"] intValue];
    self.lineColor = LINECOLOR1;
    [self setNeedsDisplay];
}

void drawHu1()
{
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //1.1 设置线条的宽度
    CGContextSetLineWidth(ctx, 10);
    //1.2 设置线条的起始点样式
    CGContextSetLineCap(ctx,kCGLineCapButt);
    //1.3  虚实切换 ，实线5虚线10
    CGFloat length[] = {2,8};
    CGContextSetLineDash(ctx, 0, length, 2);
    //1.4 设置颜色
    [[UIColor lightGrayColor] set];
    //2.设置路径
    CGContextAddArc(ctx, kScreenW/2 , kScreenW/2, 95, -5*M_PI_4, M_PI_4, 0);
    //3.绘制
    CGContextStrokePath(ctx);
    
}

-(void)setNum:(int)num
{
    _num = num;
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BGCOLOR;
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenW-120)/2, (kScreenW-80)/2, 120, 80)];
        _numLabel.textAlignment  = NSTextAlignmentCenter;
        _numLabel.textColor = [UIColor whiteColor];
        _numLabel.font = [UIFont systemFontOfSize:60];
        
        
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(change) userInfo:nil repeats:YES];
        }
        
        
        [self addSubview:_numLabel];
    }
    return self;
}

-(void)change
{
    if (_num == self.inputNum) {
        return;
    }
    _num +=1;
    
    _numLabel.text = [NSString stringWithFormat:@"%d",_num];
    _numLabel.textColor = [UIColor whiteColor];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithObjectsAndKeys:_numLabel.text,@"num", nil];
    
    NSNotification *noti = [NSNotification notificationWithName:@"number" object:nil userInfo:dic];
    [[NSNotificationCenter defaultCenter]postNotification:noti];
}

- (void)dealloc
{
    [self doSomething];
}
- (void)doSomething
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_timer invalidate];
    _timer = nil;
}

- (void)setInputNum:(int)inputNum
{
    _inputNum = inputNum;
    [self addSubview:self.circleView];
}

- (void)setRepeatFlag:(BOOL)repeatFlag
{
    _repeatFlag = repeatFlag;
    if (_repeatFlag) {
        _num = 0;
        [self change];
        self.circleView.percent = self.inputNum;
    }
    
}

@end
