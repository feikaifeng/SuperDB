//
//  SuperDBDateCell.m
//  SuperDB
//
//  Created by feikaifeng on 14-4-30.
//  Copyright (c) 2014年 feikaifeng. All rights reserved.
//

#import "SuperDBDateCell.h"

static NSDateFormatter *__dateFormatter = nil;

@interface SuperDBDateCell ()

@property (strong, nonatomic) UIDatePicker *datePicker;

-(void)datePickerChanged:(id)sender;

@end

@implementation SuperDBDateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textField.clearButtonMode=UITextFieldViewModeNever;
        self.datePicker=[[UIDatePicker alloc] initWithFrame:CGRectZero];
        self.datePicker.datePickerMode=UIDatePickerModeDate;
        
        [self.datePicker addTarget:self action:@selector(datePickerChanged:) forControlEvents:UIControlEventValueChanged];
        self.textField.inputView=_datePicker;
        
    }
    return self;
}

+(void)initialize{
    __dateFormatter =[[NSDateFormatter alloc] init];
    [__dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark - SuperDBEditCell Overrides
-(id)value{
    if (self.textField.text == nil || [self.textField.text length] == 0) {
        return nil;
    }
    return self.datePicker.date;
}

-(void)setValue:(id)value{
    if (value !=nil && [value isKindOfClass:[NSDate class]]) {
        [self.datePicker setDate:value];
        self.textField.text=[__dateFormatter stringFromDate:value];
    }else{
        self.textField.text=nil;
    }
}
#pragma mark -(Private) Instance Methods
-(void)datePickerChanged:(id)sender{
    NSDate *date=[self.datePicker date];
    
    self.value=date;
    self.textField.text=[__dateFormatter stringFromDate:date];
    
}
@end
