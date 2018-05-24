//
//  ViewController.m
//  HCRuntime
//
//  Created by hc on 2018/5/4.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+HCAction.h"
#import <objc/runtime.h>

#import "Person.h"

#import "Target.h"

#import "NSObject+Associate.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    Person *p = [[Person alloc] init];
    [p printClass];
    [p sayHello:@"zhangsan"];
    
    
    
//    NSObject *obj = [NSObject new];
//    obj.object = @"第一种实现方式";
//    NSLog(@"%@",obj.object);
    
    NSObject *obj = [NSObject new];
    obj.object = @"第二种实现方式";
    NSLog(@"%@",obj.object);
    
    
    
    
    
    
    
    
    [self createButton];
}

























- (void)createButton {
    
    UIButton *button1 = [UIButton createBtnWithFrame:CGRectMake(20, 100, 80, 30) title:@"button" actionBlock:^(UIButton *button) {
        float r = random()%255/255.0;
        float g = random()%255/255.0;
        float b = random()%255/255.0;
        self.view.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    }];
    button1.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:button1];
    
    UIButton *btn2 = [UIButton createBtnWithFrame:CGRectMake(20, 150, 120, 30) title:@"PrivateAPI" actionBlock:^(UIButton *button) {
        [self getPrivateApi];
    }];
    btn2.backgroundColor = [UIColor brownColor];
    [self.view addSubview:btn2];
    
    
    
    
    
    
    
    [button1 addClickCallback:^(UIButton *btn) {
        NSLog(@"...");
    }];
    
}

- (void)getPrivateApi{
    
    NSString *className = NSStringFromClass([UIButton class]);
    const char *cClassName = [className UTF8String];
    
    id theClass = objc_getClass(cClassName);
    
    unsigned int outCount;
    
    Method *m = class_copyMethodList(theClass, &outCount);
    
    NSLog(@"%d",outCount);
    
    for (int i = 0; i < outCount; i ++) {
        SEL a = method_getName(*(m + i));
        NSString *sn = NSStringFromSelector(a);
        NSLog(@"%@",sn);
    }
    
    
}



















@end
