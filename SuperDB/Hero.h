//
//  Hero.h
//  SuperDB
//
//  Created by feikaifeng on 14-5-8.
//  Copyright (c) 2014年 feikaifeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#define kHeroValidationDomain @"com.AppOrchard.SuperDB.HeroValidationDomain"
#define kHeroValidationBirthdateCode            1000
#define kHeroValidationNameOrSecretIdentityCode 1001

@class Power;

@interface Hero : NSManagedObject

@property (nonatomic, retain, readonly) NSNumber * age;
@property (nonatomic, retain) NSDate * birthdate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * secretIdentity;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) UIColor * favoriteColor;

@property (nonatomic, retain) NSSet *powers;
@property (nonatomic, readonly) NSArray *olderHeroes;
@property (nonatomic, readonly) NSArray *youngeHeroes;
@property (nonatomic, readonly) NSArray *sameSexHeroes;
@property (nonatomic, readonly) NSArray *oppositeSexHeroes;

@end


@interface Hero (PowerAccessors)

-(void)addPowersObject:(Power *)object;
-(void)removePowersObject:(Power*)object;
-(void)addPowers:(NSSet *)objects;
-(void)removePowers:(NSSet *)objects;
@end