//
//  Hero.m
//  SuperDB
//
//  Created by feikaifeng on 14-5-8.
//  Copyright (c) 2014年 feikaifeng. All rights reserved.
//

#import "Hero.h"


@implementation Hero

@dynamic age;
@dynamic birthdate;
@dynamic name;
@dynamic secretIdentity;
@dynamic sex;
@dynamic favoriteColor;

@dynamic powers;
@dynamic olderHeroes,youngeHeroes,sameSexHeroes,oppositeSexHeroes;

-(void)awakeFromInsert{
    self.favoriteColor=[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    self.birthdate=[NSDate date];
    
    [super awakeFromInsert];
    
}

-(BOOL)validateBirthdate:(id *)ioValue error:(NSError **)outError{
    NSDate *date=*ioValue;
    
    if ([date compare:[NSDate date]] == NSOrderedDescending) {
        if (outError != NULL) {
            NSString *errorStr=NSLocalizedString(@"Birthdate cannot be in the future", @"Birthdate cannot be in the future");
            NSDictionary *userInfoDict=[NSDictionary dictionaryWithObject:errorStr forKey:NSLocalizedDescriptionKey];
            NSError *error=[[NSError alloc] initWithDomain:kHeroValidationDomain code:kHeroValidationBirthdateCode userInfo:userInfoDict];
            
            *outError=error;
        }
        
        return NO;
    }
    return YES;
    
}

-(BOOL)validateNameOrSecretIdentity:(NSError **)outError{
    if (0 == self.name.length && 0 ==self.secretIdentity.length) {
        if (outError != NULL) {
            NSString *errorStr=NSLocalizedString(@"Must provide name or secret identity", @"Must provide name or secret identity");
            NSDictionary *userInfoDict=[NSDictionary dictionaryWithObject:errorStr forKey:NSLocalizedDescriptionKey];
            
            NSError *error=[[NSError alloc] initWithDomain:kHeroValidationDomain code:kHeroValidationNameOrSecretIdentityCode userInfo:userInfoDict];
            
            *outError = error;
        }
        
        return NO;
    }
    
    return YES;
}

-(BOOL)validateForInsert:(NSError *__autoreleasing *)error{
    return [self validateNameOrSecretIdentity:error];
}

-(BOOL)validateForUpdate:(NSError *__autoreleasing *)error{
    return [self validateNameOrSecretIdentity:error];
}

-(NSNumber *)age{
    if (self.birthdate == nil) {
        return nil;
    }
    
    NSCalendar *gregorian=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components=[gregorian components:NSYearCalendarUnit fromDate:self.birthdate toDate:[NSDate date] options:0];
    
    NSInteger years=[components year];
    
    return [NSNumber numberWithInteger:years];
}


@end
