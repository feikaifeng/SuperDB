//
//  UIColorPicker.h
//  SuperDB
//
//  Created by feikaifeng on 14-5-8.
//  Copyright (c) 2014年 feikaifeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CAGradientLayer.h>

#define kTopBackgroundColor [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0];
#define kBottomBackgroundColor [UIColor colorWithRed:0.79 green:0.79 blue:0.79 alpha:1.0];

@interface UIColorPicker : UIControl

@property (strong, nonatomic) UIColor *color;

@end
