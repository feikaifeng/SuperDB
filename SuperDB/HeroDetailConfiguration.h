//
//  HeroDetailConfiguration.h
//  SuperDB
//
//  Created by feikaifeng on 14-5-12.
//  Copyright (c) 2014年 symg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeroDetailConfiguration : NSObject

-(NSInteger) numberOfSections;
-(NSInteger) numberOfRowsInSection:(NSInteger)section;
-(NSString *) headerInSection:(NSInteger)section;
-(NSDictionary *)rowForIndexPath:(NSIndexPath *)indexPath;

-(NSString *)cellClassnameForIndexPath:(NSIndexPath *)indexPath;
-(NSArray *)valuesForIndexPath:(NSIndexPath *)indexPath;
-(NSString *)attributeKeyForIndexPath:(NSIndexPath *)indexPath;
-(NSString *)labelForIndexForIndexPath:(NSIndexPath *)indexPath;

-(BOOL)isDynamicSection:(NSInteger)section;
-(NSString *)dynamicAttributeKeyForSection:(NSInteger)section;
@end
