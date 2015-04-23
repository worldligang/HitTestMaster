//
//  LGSecondView.m
//  HitTestMaster
//
//  Created by ligang on 15/4/23.
//  Copyright (c) 2015年 ligang. All rights reserved.
//
//  我的微信iOS开发：iOSDevTip
//  我的博客地址 http://www.superqq.com

#import "LGSecondView.h"

@interface LGSecondView ()

@property (nonatomic, strong) UIButton *buttonSecond;
//#pragma mark - 方法二
//@property (nonatomic, strong) NSMutableArray *subControlsArray;

@end

@implementation LGSecondView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        #pragma mark - 方法二
//        self.subControlsArray = [NSMutableArray array];
        UIButton *buttonSecond = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonSecond.frame = CGRectMake(20, 80, 100, 50);
        [buttonSecond setBackgroundColor:[UIColor orangeColor]];
        [buttonSecond setTitle:@"second" forState:UIControlStateNormal];
        [buttonSecond setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:buttonSecond];
        [buttonSecond addTarget:self action:@selector(actionButtonSecondClick:) forControlEvents:UIControlEventTouchUpInside];
        self.buttonSecond = buttonSecond;
    }
    return self;
}

- (void)actionButtonSecondClick:(id)sender
{
    NSLog(@"second button click");
}

//#pragma mark - 方法一
//-(id)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    UIView *hitView = [super hitTest:point withEvent:event];
//    if (hitView == self)
//    {
//        return nil;
//    }
//    else
//    {
//        return hitView;
//    }
//}

//#pragma mark - 方法二
//
//- (void)addSubview:(UIView *)view{
//    [super addSubview:view];
//    if ([view isKindOfClass:[UIControl class]]) {
//        [self.subControlsArray addObject:view];
//    }
//}
//
////set self not response action and self subviews response action
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;
//{
//    BOOL toNext = YES;
//    for (UIView *view in _subControlsArray) {
//        if (CGRectContainsPoint(view.frame, point)) {
//            toNext = NO;
//            break;
//        }
//    }
//    return !toNext;
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
