//
//  Person.m
//  HCRuntime
//
//  Created by hc on 2018/5/24.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Message.h"
@implementation Person



- (void)printClass {
    
    NSLog(@"super--%@",[super class]);
    NSLog(@"self--%@",[self class]);
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
    
    
}


//第一种方式
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//
//    if (sel == @selector(sayHello:)) {
//        class_addMethod([self class], sel, imp_implementationWithBlock(^(id self,NSString *name) {
//            NSLog(@"hello %@",name);
//        }), "v@:@");
//    }
//
//    return [super resolveInstanceMethod:sel];
//}


//第二种方式
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//
//    if (sel == @selector(sayHello:)) {
//        class_addMethod([self class], sel, (IMP)say, "v@:@"); //v@:@中：v对应着返回值void，第一个@对应着第一个参数类型id，:对应着第二个参数类型SEL，第二个@对应着三个参数类型NSString
//    }
//    return [super resolveInstanceMethod:sel];
//
//}
//
//void say (id self,SEL _cmd,NSString *name) {
//    NSLog(@"hello %@",name);
//}



//第三种方式
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(sayHello:)) {
//        return [Message new];
//    }
//    return [super forwardingTargetForSelector:aSelector];
//}



//第四种方式
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {

    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];

    if (!methodSignature) {
        methodSignature = [Message instanceMethodSignatureForSelector:aSelector];
    }
    return methodSignature;
}
//转发调用
- (void)forwardInvocation:(NSInvocation *)anInvocation {

    Message *message = [Message new];
    if ([message respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:message];
    }

    
    
}







@end
