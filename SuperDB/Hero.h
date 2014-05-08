//
//  Hero.h
//  SuperDB
//
//  Created by feikaifeng on 14-5-8.
//  Copyright (c) 2014年 symg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#define kHeroValidationDomain @"com.AppOrchard.SuperDB.HeroValidationDomain"
#define kHeroValidationBirthdateCode            1000
#define kHeroValidationNameOrSecretIdentityCode 1001

@interface Hero : NSManagedObject

@property (nonatomic, retain, readonly) NSNumber * age;
@property (nonatomic, retain) NSDate * birthdate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * secretIdentity;
@property (nonatomic, retain) NSString * sex;
@property (nonatomic, retain) UIColor * favoriteColor;

@end
