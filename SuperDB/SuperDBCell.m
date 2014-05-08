//
//  SuperDBCell.m
//  
//
//  Created by feikaifeng on 14-5-8.
//
//

#import "SuperDBCell.h"
#define kLabelTextColor [UIColor colorWithRed:0.321569 green:0.4 blue:0.568627 alpha:1]

@implementation SuperDBCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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

#pragma mark - Property Overrides
-(id)value{
    return self.textField.text;
}
-(void)setValue:(id)newValue{
    if ([newValue isKindOfClass:[NSString class]]) {
        self.textField.text=newValue;
    }else{
        self.textField.text=[newValue description];
    }
}
#pragma mark - Instance Methods
-(BOOL)idEditable{
    return NO;
}
@end
