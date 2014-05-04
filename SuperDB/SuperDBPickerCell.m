//
//  SuperDBPickerCell.m
//  SuperDB
//
//  Created by feikaifeng on 14-5-4.
//  Copyright (c) 2014年 symg. All rights reserved.
//

#import "SuperDBPickerCell.h"

@interface SuperDBPickerCell ()
@property (strong,nonatomic) UIPickerView *pickerView;
@end

@implementation SuperDBPickerCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.textField.clearButtonMode=UITextFieldViewModeNever;
        
        self.pickerView=[[UIPickerView alloc] initWithFrame:CGRectZero];
        
        self.pickerView.dataSource=self;
        self.pickerView.delegate=self;
        self.pickerView.showsSelectionIndicator=YES;
        self.textField.inputView=self.pickerView;
    }
    
    return self;
}

#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return  self.values.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return  self.values[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    self.value=self.values[row];
}

#pragma mark - SuperDBEditCell Overrides
-(void)setValue:(id)value{
    if (value !=nil) {
        NSInteger index=[self.values indexOfObject:value];
        
        if (index !=NSNotFound) {
            self.textField.text=value;
        }
    }else{
        self.textField.text=nil;
    }
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
