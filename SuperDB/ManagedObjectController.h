//
//  HeroDetailController.h
//  SuperDB
//
//  Created by feikaifeng on 14-4-30.
//  Copyright (c) 2014年 feikaifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ManagedObjectConfiguration;

typedef NS_ENUM(NSUInteger, HeroEditControllerSections) {
    HeroEditControllerSectionName,
    HeroEditControllerSectionGeneral,
    HeroEditControllerSectionCount,
};

typedef NS_ENUM(NSUInteger, HeroEditControllerNameSection) {
    HeroEditControllerNameRow,
    HeroEditControllerNameSectionCount,
};

typedef NS_ENUM(NSUInteger, HeroEditControllerGeneralSection) {
    HeroEditControllerGeneralSectionSecretIdentityRow,
    HeroEditControllerGeneralSectionBirthdateRow,
    HeroEditControllerGeneralSectionSexRow,
    HeroEditControllerGeneralSectionSectionCount,
};

@interface ManagedObjectController : UITableViewController

@property (nonatomic,strong) NSManagedObject *managedObject;
@property (strong,nonatomic) ManagedObjectConfiguration *config;

- (NSManagedObject *)addRelationshipObjectForSection:(NSInteger) section;
- (void)removeRelationshipObjectInIndexPath:(NSIndexPath *)indexPath;

@end
