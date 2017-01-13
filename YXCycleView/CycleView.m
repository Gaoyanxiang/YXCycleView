//
//  CycleView.m
//  YXCycleView
//
//  Created by lenwave_IOS02 on 17/1/11.
//  Copyright © 2017年 高砚祥. All rights reserved.
//

#import "CycleView.h"

@interface CycleView ()<UIScrollViewDelegate>
{
    NSInteger centerIndex;
}

@property(nonatomic, strong) UIScrollView *scroll;
@property(nonatomic, strong) UIPageControl *pageController;
@property(nonatomic, copy) NSArray *imageAry;

@property (nonatomic, strong) UIImageView * leftImage;
@property (nonatomic, strong) UIImageView * centerImage;
@property (nonatomic, strong) UIImageView * rightImage;

@property (nonatomic, strong) NSTimer *timer;


@end


@implementation CycleView



+ (instancetype)initPhoto:(CGRect)frame imageAry:(NSArray *)imageAry
{
    CycleView *cycleView = [[CycleView alloc] initWithFrame:frame];
    cycleView.imageAry = imageAry;
    [cycleView addImageView:frame];
    cycleView.scroll.delegate = cycleView;
    return cycleView;
}


- (void)addImageView:(CGRect)frame
{
    /**
     *    (づ￣3￣)づ╭❤～ :  加载scrollView
     */
    self.scroll = [[UIScrollView alloc] initWithFrame:frame];
    self.scroll.pagingEnabled = true;
    self.scroll.showsHorizontalScrollIndicator = false;
    self.scroll.contentSize = CGSizeMake(frame.size.width*3,frame.size.height);
    [self.scroll setContentOffset:CGPointMake(frame.size.width, 0) animated:false];
    [self addSubview:self.scroll];
    
    /**
     *    (づ￣3￣)づ╭❤～ : 加载图片
     */
    self.leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    self.centerImage = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width, 0, frame.size.width, frame.size.height)];
    self.rightImage = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width*2, 0, frame.size.width, frame.size.height)];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [self.scroll addGestureRecognizer:tapGesture];
    [self.scroll addSubview:self.leftImage];
    [self.scroll addSubview:self.centerImage];
    [self.scroll addSubview:self.rightImage];

    self.leftImage.image = self.imageAry.lastObject;
    self.centerImage.image = self.imageAry.firstObject;
    self.rightImage.image = self.imageAry[1];
    
    /**
     *    (づ￣3￣)づ╭❤～ : 加载 UIPageControl
     */
    self.pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
    self.pageController.numberOfPages = self.imageAry.count;
    self.pageController.hidesForSinglePage = true;
    [self.pageController addTarget:self action:@selector(pageChange) forControlEvents:(UIControlEventValueChanged)];
    self.pageController.currentPageIndicatorTintColor = [UIColor greenColor];
    self.pageController.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:self.pageController];
    [self createTimer];

}

- (void)createTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)automaticScroll{
    [self.scroll setContentOffset:CGPointMake(self.frame.size.width*2, 0) animated:NO];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self loadImageView];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self createTimer];
}

- (void)pageChange
{
    centerIndex = self.pageController.currentPage + self.imageAry.count;
    [self changeImage];
}


- (void) changeImage{
   
    self.leftImage.image = self.imageAry[(centerIndex-1)%self.imageAry.count];
    self.centerImage.image = self.imageAry[(centerIndex)%self.imageAry.count];
    self.rightImage.image = self.imageAry[(centerIndex+1)%self.imageAry.count];
}


- (void)loadImageView{
    if (centerIndex==0) {
        centerIndex = self.imageAry.count*3;
    }
    
    if (self.scroll.contentOffset.x>=2*self.frame.size.width) {
        centerIndex = centerIndex+1;
    }else if (self.scroll.contentOffset.x<=0){
        centerIndex = centerIndex-1;
    }else{
        return;
    }
    [self changeImage];
    [self.scroll setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    self.pageController.currentPage = centerIndex%self.imageAry.count;
    
}






#pragma mark   --- 点击事件
/**
 *    (づ￣3￣)づ╭❤～ : 可以根据自己的需要来  用代理 或者block
 */
- (void)tapAction
{
    if (self.block != nil) {
        self.block(centerIndex%self.imageAry.count);
    }
}










@end
