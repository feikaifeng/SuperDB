//
//  SuperDBEditCell.m
//  SuperDB
//
//  Created by feikaifeng on 14-4-30.
//  Copyright (c) 2014年 feikaifeng. All rights reserved.
//

#import "SuperDBEditCell.h"
@implementation SuperDBEditCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        self.textField.delegate=self;

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
#pragma mark - Instance Methods
-(BOOL)idEditable{
    return YES;
}
#pragma mark - UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField{
    [self validate];
}
#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == [alertView cancelButtonIndex]) {
        [self setValue:[self.hero valueForKey:self.key]];
    }else{
        [self.textField becomeFirstResponder];
    }
}
#pragma mark - 
-(void)validate{
    id val = self.value;
    NSError *error;
    if (![self.hero validateValue:&val forKey:self.key error:&error]) {
        NSString *message=nil;
        
        if ([[error domain] isEqualToString:NSCocoaErrorDomain]) {
            NSDictionary *userInfo=[error userInfo];
            
            message=[NSString stringWithFormat:NSLocalizedString(@"Validation error on %@\rFailure Reason: %@", @"Validation error on %@\rFailure Reason: %@"),[userInfo valueForKey:NSValidationKeyErrorKey],[error localizedFailureReason]];
        }else{
            message=[error localizedDescription];

        }
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Validation Error", @"Validation Error")
                                                      message:message
                                                     delegate:self
                                            cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel")
                                            otherButtonTitles:NSLocalizedString(@"Fix", @"Fix"), nil];
        [alert show];
    }
}


@end
