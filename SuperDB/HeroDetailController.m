//
//  HeroDetailController.m
//  SuperDB
//
//  Created by feikaifeng on 14-5-13.
//  Copyright (c) 2014年 symg. All rights reserved.
//

#import "HeroDetailController.h"
#import "ManagedObjectConfiguration.h"
#import "PowerViewController.h"

@interface HeroDetailController ()

@end

@implementation HeroDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.config=[[ManagedObjectConfiguration alloc] initWithResource:@"HeroDetailConfiguration"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self removeRelationshipObjectInIndexPath:indexPath];
    }else if (editingStyle == UITableViewCellEditingStyleInsert){
        NSManagedObject *newObject=[self addRelationshipObjectForSection:indexPath.section];
        
        [self performSegueWithIdentifier:@"PowerViewSegue" sender:newObject];
    }
    
    [super tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSString *key=[self.config attributeKeyForIndexPath:indexPath];
    NSMutableSet *relationshipSet=[self.managedObject mutableSetValueForKey:key];
    NSManagedObject *relationshipObject=[[relationshipSet allObjects] objectAtIndex:indexPath.row];
    
    [self performSegueWithIdentifier:@"PowerViewSegue" sender:relationshipObject];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"PowerViewSegue"]) {
        if ([sender isKindOfClass:[NSManagedObject class]]) {
            PowerViewController *detailController=[segue destinationViewController];
            detailController.managedObject=sender;
        }
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Power Error", @"Power Error")
                                                      message:NSLocalizedString(@"Error trying to show Power detail", @"Error trying to show Power detail")
                                                     delegate:self
                                            cancelButtonTitle:NSLocalizedString(@"AW,Nuts", @"AW,Nuts")
                                            otherButtonTitles: nil];
        [alert show];
        
    }
}


@end
