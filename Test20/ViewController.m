//
//  ViewController.m
//  Test20
//
//  Created by 小雨科技 on 2017/8/8.
//  Copyright © 2017年 jiajianhao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
//    [self test1];
    
//    self.view.layer.contents
    NSArray*arr1 =[self fetchDataFromServe];
    NSLog(@"arr1:-%@",arr1);
    
}
#pragma mark -- GCD 基本
- (void) syncConcurrent
{
    NSLog(@"syncConcurrent---begin");
    
    dispatch_queue_t queue= dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"syncConcurrent---end");
}
- (void) asyncConcurrent
{
    NSLog(@"asyncConcurrent---begin");
    
    dispatch_queue_t queue= dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"asyncConcurrent---end");
}
- (void) syncSerial
{
    NSLog(@"syncSerial---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"syncSerial---end");
}

- (void) asyncSerial
{
    NSLog(@"asyncSerial---begin");
    
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"asyncSerial---end");
}

- (void)syncMain
{
    NSLog(@"syncMain---begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"syncMain---end");
}

- (void)asyncMain
{
    NSLog(@"asyncMain---begin");
    
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"asyncMain---end");
}
- (void)barrier
{
    dispatch_queue_t queue = dispatch_queue_create("12312312", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@",[NSThread currentThread]);
        }
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        NSLog(@"----4-----%@", [NSThread currentThread]);
    });
}

-(void)traversal{
    //遍历
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_apply(6, queue, ^(size_t index) {
        NSLog(@"%zd------%@",index, [NSThread currentThread]);
    });
    
 
}

-(void)test1{
    
    dispatch_group_t group =  dispatch_group_create();
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
        NSLog(@"**********************syncConcurrent*******************");
        [self syncConcurrent];
        NSLog(@"**********************syncConcurrent*******************");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
        NSLog(@"*******************asyncConcurrent**********************");
        [self asyncConcurrent];
        NSLog(@"*******************asyncConcurrent**********************");
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
        NSLog(@"********************syncSerial*********************");
        
        [self syncSerial];
        NSLog(@"********************syncSerial*********************");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
        NSLog(@"*******************asyncSerial**********************");
        
        [self asyncSerial];
        
        NSLog(@"*******************asyncSerial**********************");
    });
    
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
        NSLog(@"********************barrier*********************");
        
        [self barrier];
        NSLog(@"********************barrier*********************");
    });
    
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程...
        [self traversal];
        
    });
    
    
    //    [self syncMain];
    //    [self asyncMain];
    
    
}

#pragma mark -- Semaphore
- (__kindof NSArray  *)fetchDataFromServe{
        
        //修改下面的代码，使用信号量来进行一个同步数据
        //我们传入一个参数0 ，表示没有资源，非0 表示是有资源，这一点需要搞清楚
        //补充：这里的整形参数如果是非0 就是总资源
        dispatch_semaphore_t semaoh = dispatch_semaphore_create(0);
        
        //假如下面这个数组是用来存放数据的
        NSMutableArray * array = [NSMutableArray arrayWithCapacity:0];
        //下面这个来代替我们平时常用的异步网络请求
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (int i=0; i<10; i++) {
                [array addObject:[NSNumber numberWithInt:i]];
                
            }
            NSLog(@"array = %@",array);
            //发送信号，信号量  管理资源数+1  车辆如果遇到绿色信号灯，等待的车辆就会减少，也就是资源数减少，一直减少到 dispatch_semaphore_wait  这个函数返回 0 才会继续执行，
            
            dispatch_semaphore_signal(semaoh);
            
        });
        //信号等待 时，资源数 -1  阻塞当前线程 这个难理解的可以理解成等待红绿灯的车辆，红灯等待车辆
        //车辆自然是累加的排队等候，没有资源，会一直触发信号控制
        dispatch_semaphore_wait(semaoh, DISPATCH_TIME_FOREVER);
        
        
        return array;
    
 }

#pragma mark -- Group
- (void)groupSync
{
    dispatch_queue_t disqueue =  dispatch_queue_create("com.shidaiyinuo.NetWorkStudy", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t disgroup = dispatch_group_create();
    dispatch_group_async(disgroup, disqueue, ^{
        NSLog(@"任务一完成");
    });
    dispatch_group_async(disgroup, disqueue, ^{
        sleep(8);
        NSLog(@"任务二完成");
    });
    dispatch_group_notify(disgroup, disqueue, ^{
        NSLog(@"dispatch_group_notify 执行");
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_group_wait(disgroup, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC));
        //dispatch_group_wait不能在主线程中执行，会造成死锁。。。在
        NSLog(@"dispatch_group_wait 结束");
    });
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
