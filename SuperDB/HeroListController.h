//
//  HeroListController.h
//  SuperDB
//
//  Created by feikaifeng on 14-4-29.
//  Copyright (c) 2014年 symg. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kSelectedTabDefaultsKey @"Selected Tab"


enum{
    kByName,
    kBySecretIdentity,
};

@interface HeroListController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITabBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *heroTableView;
@property (weak, nonatomic) IBOutlet UITabBar *heroTabBar;

- (IBAction)addHero:(id)sender;
@end
