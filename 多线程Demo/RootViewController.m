//
//  RootViewController.m
//  多线程Demo
//
//  Created by wangshuai on 14-1-8.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 300, 300)];
    [self.view addSubview:_imageView];
    [_imageView setBackgroundColor:[UIColor lightGrayColor]];
    
    UIButton *tongbuButton = [[UIButton alloc]initWithFrame:CGRectMake(35, 350, 100, 30)];
    [self.view addSubview:tongbuButton];
    [tongbuButton setBackgroundColor:[UIColor grayColor]];
    [tongbuButton setTitle:@"同步" forState:UIControlStateNormal];
    [tongbuButton addTarget:self action:@selector(syncAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *yibuButton = [[UIButton alloc]initWithFrame:CGRectMake(185, 350, 100, 30)];
    [self.view addSubview:yibuButton];
    [yibuButton setBackgroundColor:[UIColor grayColor]];
    [yibuButton setTitle:@"异步" forState:UIControlStateNormal];
    [yibuButton addTarget:self action:@selector(asyncAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *ceshi = [[UIButton alloc]initWithFrame:CGRectMake(20, 400, 280, 70)];
    [self.view addSubview:ceshi];
    [ceshi setBackgroundColor:[UIColor lightGrayColor]];
    [ceshi setTitle:@"测试" forState:UIControlStateNormal];
    [ceshi addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark -
/**
 *  网络加载图片方法
 */
- (void)loadImage{
    
    
//   1. NSThread的方法

    NSLog(@"是否为主线程:%@",[NSThread isMainThread]?@"YES":@"NO");//判断是否为主线程
//   2.获取当前线程
    NSLog(@"当前线程:%@",[NSThread currentThread]);
//   3.线程休眠
//    [NSThread sleepForTimeInterval:2];//休眠两秒
    


    
    NSLog(@"qqq");
    NSURL *imageURL = [NSURL URLWithString:@"http://pic3.178.com/313/3131992/month_1312/920233a50eae238a24aaa06941b01d36.jpg"];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    [_imageView setImage:[UIImage imageWithData:imageData]];
    
    
    
}
/**
 *  同步方法
 */
- (void)syncAction{
    [self loadImage];
}
/**
 *  异步方法
 */
- (void)asyncAction{
    /**
     *  四种方法
     */
//  1.运行时多线程
//    [self performSelectorInBackground:@selector(loadImage) withObject:Nil];
    
    
//  2.NSThread
//    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(loadImage) object:Nil];
//    [thread start];//线程开始运行
    
    //优点:可以直观的控制线程。
    //缺点:手动管理线程的生命周期,线程同步等等操作,对系统有一定开销。
    
//    NSThread detachNewThreadSelector:<#(SEL)#> toTarget:<#(id)#> withObject:<#(id)#>   //自动开始
    
    
//  3.NSOperation
    //优点:基于OC开发,不需要你管理线程生命周期,线程同步。
    
    // *** NSInvocationOperation
//    NSInvocationOperation *invocation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(loadImage) object:Nil];
//    [invocation start];
    
    // *** NSBlockOperation
//    NSBlockOperation *block = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"---");
//        [self loadImage];
//    }];
//    
//    /**
//     *  给NSBlockOperation添加一个线程操作   (并行)
//     */
//    [block addExecutionBlock:^{
//        
//        NSLog(@"是否为主线程:%@",[NSThread isMainThread]?@"YES":@"NO");//判断是否为主线程
//        //   2.获取当前线程
//        NSLog(@"当前线程:%@",[NSThread currentThread]);
//    }];
//    
//    [block start];
    
    // *** NSOperationQueue
//    NSOperationQueue *queue = [[NSOperationQueue alloc]init];//永远在子线程运行
//    [queue addOperationWithBlock:^{
//        [self loadImage];
//    }];
    
//  4.  *****  GCD -- Grand Central Dispatch   (大中央调度中心)
    //强调一个队列概念，队列:queue 分为两种 类型:串行(Serial)/并行(Concurrent)
    
    //创建一个自定义的串行
//    dispatch_queue_t serial = dispatch_queue_create("tianyi", DISPATCH_QUEUE_SERIAL);
//    
//    //在串行队列种执行方法
//    dispatch_async(serial, ^{
//        //执行代码
//        NSLog(@"++++++++++++");
//        for (int i = 0; i < 10000; i++) {
//            NSLog(@"%d",i);
//        }
//    });
//    dispatch_async(serial, ^{
//        NSLog(@"_______");
//        for (int i = 10000; i > 0; i--) {
//            NSLog(@"%d",i);
//        }
//    });
    
    
    
//    //自定义并行队列
//    dispatch_queue_t concurrent = dispatch_queue_create("tianyi", DISPATCH_QUEUE_CONCURRENT);
//    
//    //在并行队列种执行方法
//    dispatch_async(concurrent, ^{
//        //执行代码
//        NSLog(@"++++++++++++");
//        for (int i = 0; i < 10000; i++) {
//            NSLog(@"%d",i);
//        }
//    });
//    dispatch_async(concurrent, ^{
//        NSLog(@"_______");
//        for (int i = 10000; i > 0; i--) {
//            NSLog(@"%d",i);
//        }
//    });
    
    
    //调用系统的主队列(串行)
    dispatch_queue_t main = dispatch_get_main_queue();
    //调用系统的全局队列(并行)
    dispatch_queue_t golbal = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
    
    dispatch_async(golbal, ^{
        //子线程网络获取图片
        NSURL *imageURL = [NSURL URLWithString:@"http://pic3.178.com/313/3131992/month_1312/920233a50eae238a24aaa06941b01d36.jpg"];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        //转到主线程加载
        dispatch_async(dispatch_get_main_queue(), ^{
            [_imageView setImage:[UIImage imageWithData:imageData]];
            
            
            
            NSLog(@"是否为主线程:%@",[NSThread isMainThread]?@"YES":@"NO");//判断是否为主线程
            //   2.获取当前线程
            NSLog(@"当前线程:%@",[NSThread currentThread]);
        });
    });
    
    //GCD 高阶用法1:dispatch_once_t   创建单列代码块
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//    });
    
//    //2.休眠2秒后执行一个方法
//    double delayInSeconds = 2.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        NSLog(@"00000");
//    });
//    //3.多次执行
//    //<#size_t iterations#>(5) -- 执行多少次
//    //size_t a--a:执行的第几次
//    dispatch_apply(5, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t a){
//        NSLog(@"%zu",a);
//    });
    
    //4.等待前面完成之后
    
    //略
    
}

/**
 *  测试线程阻塞方法
 */
- (void)testAction{
    NSLog(@"====");
}
#pragma mark -

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
