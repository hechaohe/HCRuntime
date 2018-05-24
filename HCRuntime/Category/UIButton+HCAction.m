//
//  UIButton+HCAction.m
//  HCRuntime
//
//  Created by hc on 2018/5/4.
//  Copyright © 2018年 ios. All rights reserved.
//

#import "UIButton+HCAction.h"

#import <objc/runtime.h>
static NSString *keyOfMethod;
static NSString *keyOfBlock;
@implementation UIButton (HCAction)



+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title actionBlock:(ActionBlock)actionBlock {
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:button action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    objc_setAssociatedObject(button, &keyOfMethod, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    return button;
}

- (void)buttonClick:(UIButton *)button {
    
    ActionBlock block1 = (ActionBlock)objc_getAssociatedObject(button, &keyOfMethod);
    if (block1) {
        block1(button);
    }
    
    ActionBlock block2 = (ActionBlock)objc_getAssociatedObject(button, &keyOfBlock);
    if (block2) {
        block2(button);
    }
    
}


- (void)setActionBlock:(ActionBlock)actionBlock {
    
    objc_setAssociatedObject(self, &keyOfBlock, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}
- (ActionBlock)actionBlock {
    return objc_getAssociatedObject(self, &keyOfBlock);
}







//
// 声明一个静态的索引key，用于获取被关联对象的值
static char *buttonClickKey;
- (void)addClickCallback:(ButtonClickCallBackBlock)callback {
    // 将button的实例与回调的block通过索引key进行关联：
    objc_setAssociatedObject(self, &buttonClickKey, callback, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    // 设置button执行的方法
    [self addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)buttonClicked {
    ButtonClickCallBackBlock callback = objc_getAssociatedObject(self, &buttonClickKey);
    if (callback) {
        callback(self);
    }
}















@end
