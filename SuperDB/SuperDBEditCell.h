//
//  SuperDBEditCell.h
//  SuperDB
//
//  Created by feikaifeng on 14-4-30.
//  Copyright (c) 2014年 feikaifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SuperDBCell.h"

@interface SuperDBEditCell : SuperDBCell<UITextFieldDelegate,UIAlertViewDelegate>

-(void)validate;

@end
