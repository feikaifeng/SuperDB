//
//  SuperDBEditCell.h
//  SuperDB
//
//  Created by feikaifeng on 14-4-30.
//  Copyright (c) 2014年 symg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SuperDBEditCell : UITableViewCell<UITextFieldDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UITextField *textField;

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) id value;
@property (strong, nonatomic) NSManagedObject *hero;

-(void)validate;

@end
