//
//  SuperDBEditCell.m
//  SuperDB
//
//  Created by feikaifeng on 14-4-30.
//  Copyright (c) 2014年 symg. All rights reserved.
//

#import "SuperDBEditCell.h"
#define kLabelTextColor [UIColor colorWithRed:0.321569 green:0.4 blue:0.568627 alpha:1]

@implementation SuperDBEditCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        self.label=[[UILabel alloc] initWithFrame:CGRectMake(12, 15, 67, 15)];
        self.label.backgroundColor=[UIColor clearColor];
        self.label.font=[UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        self.label.textAlignment=NSTextAlignmentRight;
        self.label.textColor=kLabelTextColor;
        self.label.text=@"label";
        [self.contentView addSubview:self.label];
        
        self.textField=[[UITextField alloc] initWithFrame:CGRectMake(93, 13, 170, 19)];
        self.textField.backgroundColor=[UIColor clearColor];
        self.textField.clearButtonMode=UITextFieldViewModeWhileEditing;
        self.textField.enabled=NO;
        self.textField.font=[UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        self.textField.text=@"Title";
        [self.contentView addSubview:self.textField];
    }
    return self;
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

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    
    self.textField.enabled=editing;
}
#pragma mark - Property Overrides
-(id)value{
    return self.textField.text;
}
-(void)setValue:(id)value{
    self.textField.text=value;
}


@end
