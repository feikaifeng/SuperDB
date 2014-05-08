//
//  HeroListController.h
//  SuperDB
//
//  Created by feikaifeng on 14-4-29.
//  Copyright (c) 2014年 feikaifeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSelectedTabDefaultsKey @"Selected Tab"

enum{
    kByName,
    kBySecretIdentity,
};

@interface HeroListController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITabBarDelegate,NSFetchedResultsControllerDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *heroTableView;
@property (weak, nonatomic) IBOutlet UITabBar *heroTabBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

- (IBAction)addHero:(id)sender;
@end
