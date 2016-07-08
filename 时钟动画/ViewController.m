//
//  ViewController.m
//  时钟动画
//
//  Created by 王奥东 on 16/3/22.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//保存秒针的Layer
@property(nonatomic,strong)CALayer *secondL;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建一个Layer作为时钟盘并添加到View
    CALayer *layer = [CALayer layer];
    layer.contents = (id)[UIImage imageNamed:@"clock"].CGImage;
    //anchorPoint锚点 决定当前layert以自身的那个位置 显示在 父layer的坐标上
    //显示的位置是position设置的位置
    layer.position = self.view.center;
    layer.bounds = CGRectMake(0, 0, 150, 150);
    layer.cornerRadius = 75;
    [self.view.layer addSublayer:layer];
    
    //创建一个Layer为秒针
    CALayer *secondLine = [CALayer layer];
    secondLine.bounds = CGRectMake(0, 0, 1, 75);
    //anchorPoint锚点 决定当前layert以自身的那个位置 显示在 父layer的坐标上
    secondLine.position = CGPointMake(75, 75);
    secondLine.anchorPoint = CGPointMake(0.5,0.8);
    secondLine.backgroundColor = (__bridge CGColorRef _Nullable)((id)[UIColor redColor].CGColor);
    [layer addSublayer:secondLine];
    
    //保存miaozhen
    self.secondL = secondLine;
    
    //使用DisplayLink（刷帧计时器）执行转动循环，一秒会调用60次
//    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(move)];
//    //添加到主运行循环中
//    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
 
    //使用NSTimer执行转动循环，设置间隔时间为1.0秒
    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(move) userInfo:nil repeats:YES];
}
-(void)move{
    
    //一秒钟的角度：180/30
    CGFloat add = M_PI/30;
    
    //获取时间
    NSDate *date = [NSDate date];
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    formatter.dateFormat=@"ss";
//    NSString *dateStr = [formatter stringFromDate:date];
    
    //此两步操作相当于上面三步
    //目的是为了获取当前的秒数
    //获取当前的日历
    NSCalendar *lendar = [NSCalendar currentCalendar];
    //获取日历中的某一部分
    //NSCalendarUnit) 日期中的某个单元 单位
    NSInteger second = [lendar component:NSCalendarUnitSecond fromDate:date];
    //设置当前秒数的角度
    add = add*second;
    //旋转秒针
    //参数分别为x,y,z轴
    self.secondL.transform = CATransform3DMakeRotation(add, 0, 0, 1);
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
