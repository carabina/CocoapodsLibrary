//
//  ZCCalendarManageView.m
//  CocoapodsLibrary
//
//  Created by 王志超 on 2017/10/20.
//  Copyright © 2017年 王志超. All rights reserved.
//

#import "ZCCalendarManageView.h"
#import <ZCEasyLibrary/NSDate+ZCSupp.h>
#import <ZCEasyLibrary/ZCCalendar.h>

@interface ZCCalendarManageView () {
    ZCCalendarView *oldView;
    ZCCalendarView *newView;
    BOOL isAnimat;
}

@end

@implementation ZCCalendarManageView
@synthesize monthFrame;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialView];
        self.monthFrame = frame;
    }
    return self;
}

#pragma mark - init view
- (void)initialView {
    isAnimat = NO;
    self.date = [NSDate date];
    [ZCCalendar shared].firstWeekday = ZCCalendarMonday;
    
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    
    [self addSwipeGesture];
    
    {
        UIView *dayView = [[UIView alloc] init];
        dayView.backgroundColor = [UIColor clearColor];
        dayView.layer.masksToBounds = YES;
        [self addSubview:dayView];
        
        newView = [[ZCCalendarView alloc] init];
        oldView = [[ZCCalendarView alloc] init];
        [dayView addSubview:newView];
        [dayView addSubview:oldView];
    }
    self.date = nil;
}

- (void)setMonthFrame:(CGRect)_monthFrame {
    monthFrame = _monthFrame;
    self.frame = monthFrame;
    newView.frame = oldView.frame = newView.superview.frame = self.bounds;
}

#pragma mark - config data
- (ZCCalendarView *)nowShowCalendarView {
    return newView;
}

- (void)setSetCalendarView:(void (^)(ZCCalendarView *))block {
    if(block) {
        block(newView);
        block(oldView);
    }
}

- (void)setDate:(NSDate *)_date {
    oldView.date = _date;
    [self setNeedsDisplay];
}

- (void)reloadData {
    [newView reloadData];
}

#pragma mark - 切换月份
- (void)addSwipeGesture{
    UISwipeGestureRecognizer *previousSGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(changePreviousMonth)];
    [previousSGR setDirection:UISwipeGestureRecognizerDirectionDown];
    [self addGestureRecognizer:previousSGR];
    
    UISwipeGestureRecognizer *nextSGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(changeNextMonth)];
    [nextSGR setDirection:UISwipeGestureRecognizerDirectionUp];
    [self addGestureRecognizer:nextSGR];
}

- (void)changePreviousMonth {
    isAnimat = YES;
    //oldView.frame = ({CGRect rect = oldView.frame; rect.origin.x = -rect.size.width; rect;}); // 左右
    oldView.frame = ({CGRect rect = oldView.frame; rect.origin.y = -rect.size.height; rect;}); // 上下
    self.date = self.nowShowCalendarView.date.zc_previousMonthStartDate;
}

- (void)changeNextMonth {
    isAnimat = YES;
    //oldView.frame = ({CGRect rect = oldView.frame; rect.origin.x = rect.size.width; rect;}); // 左右
    oldView.frame = ({CGRect rect = oldView.frame; rect.origin.y = rect.size.height; rect;}); // 上下
    self.date = self.nowShowCalendarView.date.zc_nextMonthStartDate;
}

#pragma mark - 动画
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    oldView.hidden = NO;
    
    [UIView animateWithDuration:(isAnimat ? 0.35 : 0) animations:^{
        CGRect tmp = oldView.frame;
        oldView.frame = ({ CGRect rect = oldView.frame; rect.origin.y = 0; rect.origin.x = 0; rect; });
        newView.frame = ({ CGRect rect = newView.frame; rect.origin.y = -tmp.origin.y; rect.origin.x = -tmp.origin.x; rect; });
    } completion:^(BOOL finished) {
        id tmp = oldView;
        oldView = newView;
        newView = tmp;
        
        oldView.hidden = YES;
    }];
    isAnimat = NO;
}

@end
