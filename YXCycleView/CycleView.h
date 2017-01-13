//
//  CycleView.h
//  YXCycleView
//
//  Created by lenwave_IOS02 on 17/1/11.
//  Copyright © 2017年 高砚祥. All rights reserved.
//

#import <UIKit/UIKit.h>


#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height


@interface CycleView : UIView


/**
 *    (づ￣3￣)づ╭❤～ :       通过 scrollview 简单的实现 无限轮播
 
                   1. imageAry.count 必须大于1,(没有加判断) 可以是两张
                   2. Image类型加载等可以自己去更改源文件
                   3. 欢迎加群 2139869895
 */


@property (nonatomic, copy) void(^block)(NSInteger index);


+ (instancetype)initPhoto:(CGRect)frame imageAry:(NSArray *)imageAry;











@end
