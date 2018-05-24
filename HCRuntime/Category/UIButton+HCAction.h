//
//  UIButton+HCAction.h
//  HCRuntime
//
//  Created by hc on 2018/5/4.
//  Copyright © 2018年 ios. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ActionBlock)(UIButton *button);

typedef void (^ButtonClickCallBackBlock)(UIButton *btn);// 声明一个button点击事件的回调block


@interface UIButton (HCAction)

@property (nonatomic,copy) ActionBlock actionBlock;

+ (UIButton *)createBtnWithFrame:(CGRect)frame title:(NSString *)title actionBlock:(ActionBlock)actionBlock;

// 为UIButton增加的回调方法
- (void)addClickCallback:(ButtonClickCallBackBlock)callback;

@end
