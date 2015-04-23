//
//  ViewController.m
//  HitTestMaster
//
//  Created by ligang on 15/4/23.
//  Copyright (c) 2015年 ligang. All rights reserved.
//
//  我的微信iOS开发：iOSDevTip
//  我的博客地址 http://www.superqq.com


#import "ViewController.h"
#import "LGFirstView.h"
#import "LGSecondView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LGFirstView *firstView = [[LGFirstView alloc] initWithFrame:CGRectMake(20, 200, 200, 200)];
    firstView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:firstView];
    
    LGSecondView *secondView = [[LGSecondView alloc] initWithFrame:CGRectMake(20, 100, 200, 200)];
    secondView.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.1];
    [self.view addSubview:secondView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
