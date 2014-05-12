//
//  Power.h
//  SuperDB
//
//  Created by feikaifeng on 14-5-12.
//  Copyright (c) 2014年 symg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hero;

@interface Power : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * source;
@property (nonatomic, retain) Hero *hero;

@end
