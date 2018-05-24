//
//  NSObject+Associate.m
//  HCRuntime
//
//  Created by hc on 2018/5/24.
//  Copyright © 2018年 ios. All rights reserved.
//


//第一种方式
//#import "NSObject+Associate.h"
//
//@implementation NSObject (Associate)
//
//static id _object = nil;
//
//
//- (void)setObject:(id)object {
//    _object = object;
//}
//
//- (id)object {
//    return _object;
//}
//
//
//@end



//第二种方式runtime
#import "NSObject+Associate.h"

#import <objc/runtime.h>

@implementation NSObject (Associate)

static char const *objectKey;

- (void)setObject:(id)object {

    objc_setAssociatedObject(self, objectKey, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (id)object {
    return objc_getAssociatedObject(self, objectKey);
}

@end












