//
//  ViewController.m
//  YXCycleView
//
//  Created by lenwave_IOS02 on 17/1/11.
//  Copyright © 2017年 高砚祥. All rights reserved.
//

#import "ViewController.h"
#import "CycleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    CycleView *cycle = [CycleView initPhoto:self.view.frame imageAry:@[[UIImage imageNamed:@"1"],
                                                                       [UIImage imageNamed:@"2"],
                                                                       [UIImage imageNamed:@"3"],
                                                                       [UIImage imageNamed:@"4"],
                                                                       [UIImage imageNamed:@"5"],
                                                                       [UIImage imageNamed:@"6"],
                                                                       [UIImage imageNamed:@"7"]]];
    
    cycle.block = ^(NSInteger index){
        NSLog(@"点击了 %lu", index);
    };
    [self.view addSubview:cycle];




}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
