//
//  ViewController.m
//  DynamicCircleProgress
//
//  Created by CoDancer on 16/12/8.
//  Copyright © 2016年 CoDancer. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Extensions.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *repeatBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithHex:0xDBDBDB];
    
    //创建自定义的仪表盘
    _huView = [[HuView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenW)];
    _huView.inputNum = 75;
    [self.view addSubview:_huView];
    [self.view addSubview:self.repeatBtn];
}

- (UIButton *)repeatBtn {
    if (!_repeatBtn) {
        _repeatBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, kScreenW - 20, 30)];
        [_repeatBtn setTitle:@"Repeat" forState:UIControlStateNormal];
        [_repeatBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
        [_repeatBtn addTarget:self
                       action:@selector(repeatAni)
             forControlEvents:UIControlEventTouchUpInside];
        [_repeatBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_repeatBtn setBackgroundColor:[UIColor colorWithHex:0x48D1CC]];
        _repeatBtn.layer.cornerRadius = 5.0f;
        _repeatBtn.clipsToBounds = YES;
        _repeatBtn.center = CGPointMake(kScreenW/2.0, kScreenW + 20);
    }
    return _repeatBtn;
}

- (void)repeatAni {
    
    _huView.repeatFlag = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
