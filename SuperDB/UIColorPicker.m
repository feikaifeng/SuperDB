//
//  UIColorPicker.m
//  SuperDB
//
//  Created by feikaifeng on 14-5-8.
//  Copyright (c) 2014年 feikaifeng. All rights reserved.
//

#import "UIColorPicker.h"

@interface UIColorPicker ()

@property (strong,nonatomic) UISlider *redSlider;
@property (strong,nonatomic) UISlider *greenSlider;
@property (strong,nonatomic) UISlider *blueSlider;
@property (strong,nonatomic) UISlider *alphaSlider;

-(void)sliderChanged:(id)sender;
-(UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text;

@end

@implementation UIColorPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.autoresizingMask=UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        [self addSubview:[self labelWithFrame:CGRectMake(20,40, 60, 24) text:@"Red"]];
        [self addSubview:[self labelWithFrame:CGRectMake(20,80, 60, 24) text:@"Green"]];
        [self addSubview:[self labelWithFrame:CGRectMake(20,120, 60, 24) text:@"Blue"]];
        [self addSubview:[self labelWithFrame:CGRectMake(20,160, 60, 24) text:@"Alpha"]];
        
        _redSlider = [[UISlider alloc] initWithFrame:CGRectMake(100, 40, 190, 24)];
        _greenSlider = [[UISlider alloc] initWithFrame:CGRectMake(100, 80, 190, 24)];
        _blueSlider = [[UISlider alloc] initWithFrame:CGRectMake(100, 120, 190, 24)];
        _alphaSlider = [[UISlider alloc] initWithFrame:CGRectMake(100, 160, 190, 24)];
        
        [_redSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
        [_greenSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
        [_blueSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
        [_alphaSlider addTarget:self action:@selector(sliderChanged:) forControlEvents:UIControlEventValueChanged];
        
        [self addSubview:_redSlider];
        [self addSubview:_greenSlider];
        [self addSubview:_blueSlider];
        [self addSubview:_alphaSlider];
    }
    return self;
}

#pragma mark - Property Overrides
-(void)setColor:(UIColor *)color{
    _color =color;
    
    const CGFloat *components=CGColorGetComponents(color.CGColor);
    [_redSlider setValue:components[0]];
    [_greenSlider setValue:components[1]];
    [_blueSlider setValue:components[2]];
    [_alphaSlider setValue:components[3]];
    
}

#pragma mark - (Private) Instance Methods
-(void)sliderChanged:(id)sender{
    _color=[UIColor colorWithRed:_redSlider.value green:_greenSlider.value blue:_blueSlider.value alpha:_alphaSlider.value];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(UILabel *)labelWithFrame:(CGRect)frame text:(NSString *)text{
    UILabel *label=[[UILabel alloc] initWithFrame:frame];
    
    label.userInteractionEnabled=NO;
    label.backgroundColor=[UIColor clearColor];
    label.font=[UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    label.textAlignment=NSTextAlignmentRight;
    label.textColor=[UIColor darkGrayColor];
    label.text=text;
    
    return label;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
