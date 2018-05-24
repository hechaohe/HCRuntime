//
//  Person.h
//  HCRuntime
//
//  Created by hc on 2018/5/24.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "Animal.h"

@interface Person : Animal


- (void)printClass;


//再次声明，但不在.m实现
- (void)sayHello:(NSString *)name;


@end
