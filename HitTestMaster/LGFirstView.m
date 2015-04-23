//
//  LGFirstView.m
//  HitTestMaster
//
//  Created by ligang on 15/4/23.
//  Copyright (c) 2015年 ligang. All rights reserved.
//
//  我的微信iOS开发：iOSDevTip
//  我的博客地址 http://www.superqq.com


#import "LGFirstView.h"

@interface LGFirstView ()
@property (nonatomic, strong) UIButton *buttonFirst;

@end

@implementation LGFirstView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIButton *buttonFirst = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonFirst.frame = CGRectMake(20, 20, 100, 50);
        [buttonFirst setTitle:@"first" forState:UIControlStateNormal];
        [buttonFirst setBackgroundColor:[UIColor orangeColor]];
        [buttonFirst setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self addSubview:buttonFirst];
        [buttonFirst addTarget:self action:@selector(actionButtonFirstClick:) forControlEvents:UIControlEventTouchUpInside];
        self.buttonFirst = buttonFirst;
    }
    return self;
}

- (void)actionButtonFirstClick:(id)sender
{
    NSLog(@"first button click");
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 当touch point是在self.buttonFirst上，则hitTest返回self.buttonFirst
    CGPoint btnPointInA = [self.buttonFirst convertPoint:point fromView:self];
    if ([self.buttonFirst pointInside:btnPointInA withEvent:event]) {
        return self.buttonFirst;
    }
    // 否则，返回默认处理
    return [super hitTest:point withEvent:event];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
