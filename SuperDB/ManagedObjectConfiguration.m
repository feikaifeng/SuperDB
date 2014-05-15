//
//  HeroDetailConfiguration.m
//  SuperDB
//
//  Created by feikaifeng on 14-5-12.
//  Copyright (c) 2014年 symg. All rights reserved.
//

#import "ManagedObjectConfiguration.h"

@interface ManagedObjectConfiguration ()

@property (strong, nonatomic) NSArray *sections;

@end

@implementation ManagedObjectConfiguration

-(id)initWithResource:(NSString *)resource{
    self=[super init];
    if (self) {
        NSURL *url=[[NSBundle mainBundle] URLForResource:resource withExtension:@"plist"];
        NSDictionary *plist=[NSDictionary dictionaryWithContentsOfURL:url];
        self.sections = [plist valueForKey:@"sections"];
    }
    
    return self;
}

-(NSInteger)numberOfSections{
    return self.sections.count;
}

-(NSInteger)numberOfRowsInSection:(NSInteger)section{
    NSDictionary *sectionDict=[self.sections objectAtIndex:section];
    NSArray *rows=[sectionDict valueForKey:@"rows"];
    
    return rows.count;
}

-(NSString *)headerInSection:(NSInteger)section{
    NSDictionary *sectionDict=[self.sections objectAtIndex:section];
    
    return [sectionDict valueForKey:@"header"];
    
}
-(NSDictionary *)rowForIndexPath:(NSIndexPath *)indexPath{
    NSUInteger sectionIndex=[indexPath section];

    NSUInteger rowIndex=([self isDynamicSection:sectionIndex]) ? 0 :[indexPath row];
    
    NSDictionary *section=self.sections[sectionIndex];
    NSArray *rows=[section valueForKey:@"rows"];
    NSDictionary *row=rows[rowIndex];
    
    return row;
}

-(NSString *)cellClassnameForIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *row=[self rowForIndexPath:indexPath];
    return [row objectForKey:@"class"];
}

-(NSArray *)valuesForIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *row=[self rowForIndexPath:indexPath];

    return [row objectForKey:@"values"];
}

-(NSString *)attributeKeyForIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *row=[self rowForIndexPath:indexPath];
    
    return [row objectForKey:@"key"];
    
}

-(NSString *)labelForIndexForIndexPath:(NSIndexPath *)indexPathP{
    NSDictionary *row=[self rowForIndexPath:indexPathP];
    
    return [row objectForKey:@"label"];
}

-(BOOL)isDynamicSection:(NSInteger)section{
    BOOL dynamic=NO;
    NSDictionary *sectionDict=[self.sections objectAtIndex:section];
    NSNumber *dynamicNumber=[sectionDict objectForKey:@"dynamic"];
    if (dynamicNumber !=nil) {
        dynamic=[dynamicNumber boolValue];
    }
    
    return dynamic;
}
-(NSString *)dynamicAttributeKeyForSection:(NSInteger)section{
    if (![self isDynamicSection:section]) {
        return nil;
    }
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:section];
    
    return [self attributeKeyForIndexPath:indexPath];
}
@end
