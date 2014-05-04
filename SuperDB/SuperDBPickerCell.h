//
//  SuperDBPickerCell.h
//  SuperDB
//
//  Created by feikaifeng on 14-5-4.
//  Copyright (c) 2014年 symg. All rights reserved.
//

#import "SuperDBEditCell.h"

@interface SuperDBPickerCell : SuperDBEditCell<UIPickerViewDataSource,UIPickerViewDelegate>

@property (strong, nonatomic) NSArray *values;

@end
