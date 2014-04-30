//
//  HeroListController.m
//  SuperDB
//
//  Created by feikaifeng on 14-4-29.
//  Copyright (c) 2014年 symg. All rights reserved.
//

#import "HeroListController.h"
#import "AppDelegate.h"

@interface HeroListController ()

@property (nonatomic, strong,readonly) NSFetchedResultsController *fetchedResultsController;

@end

@implementation HeroListController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSInteger selectedTab=[defaults integerForKey:kSelectedTabDefaultsKey];
    UITabBarItem *item=self.heroTabBar.items[selectedTab];
    [self.heroTabBar setSelectedItem:item];
    
    NSError *error=nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error loading data" message:@"Error was:%@,qutting." delegate:self cancelButtonTitle:@"AW,NUTS" otherButtonTitles: nil];
        
        [alert show];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITabBarDelegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSUInteger tabIndex=[tabBar.items indexOfObject:item];
    [defaults setInteger:tabIndex forKey:kSelectedTabDefaultsKey];
    [defaults synchronize];
    
    [NSFetchedResultsController deleteCacheWithName:@"Hero"];
    _fetchedResultsController.delegate=nil;
    _fetchedResultsController=nil;
    
    NSError *error=nil;
    
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Error performing fetch :%@",[error localizedDescription]);
        
    }
    
    [self.heroTableView reloadData];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    id<NSFetchedResultsSectionInfo> sectionInfo=[self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeroListCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSManagedObject *aHero=[self.fetchedResultsController objectAtIndexPath:indexPath];
    NSInteger tab=[self.heroTabBar.items indexOfObject:self.heroTabBar.selectedItem];
    switch (tab) {
        case kByName:
            cell.textLabel.text=[aHero valueForKey:@"name"];
            cell.detailTextLabel.text=[aHero valueForKey:@"secretIdentity"];
            break;
        case kBySecretIdentity:
            cell.textLabel.text=[aHero valueForKey:@"secretIdentity"];
            cell.detailTextLabel.text=[aHero valueForKey:@"name"];
            break;
            
        default:
            break;
    }
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *managedObjectContext=[self.fetchedResultsController managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        
        NSError *error;
        if (![managedObjectContext save:&error]) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error saving entity" message:@"Error was:%@,qutting." delegate:self cancelButtonTitle:@"AW,NUTS" otherButtonTitles: nil];
            
            [alert show];
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - FetchedResultsController Porperty
-(NSFetchedResultsController *)fetchedResultsController{
    if (_fetchedResultsController !=nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    AppDelegate *appDelegate=[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext=[appDelegate managedObjectContext];
    NSEntityDescription *entityDescription=[NSEntityDescription entityForName:@"Hero" inManagedObjectContext:managedObjectContext];
    
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setFetchBatchSize:20];
    
    NSUInteger tabIndex=[self.heroTabBar.items indexOfObject:self.heroTabBar.selectedItem];
    if (tabIndex == NSNotFound) {
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        tabIndex=[defaults integerForKey:kSelectedTabDefaultsKey];
        
    }
    
    NSString *sectionKey=nil;
    
    switch (tabIndex) {
        case kByName:{
            
            NSSortDescriptor *sortDescriptor1=[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            NSSortDescriptor *sortDescriptor2=[[NSSortDescriptor alloc] initWithKey:@"secretIdentity" ascending:YES];
            NSArray *sortDescriptors=[[NSArray alloc] initWithObjects:sortDescriptor1,sortDescriptor2, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
            sectionKey=@"name";
            
            break;
        }
        case kBySecretIdentity:{
            
            NSSortDescriptor *sortDescriptor1=[[NSSortDescriptor alloc] initWithKey:@"secretIdentity" ascending:YES];
            NSSortDescriptor *sortDescriptor2=[[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
            NSArray *sortDescriptors=[[NSArray alloc] initWithObjects:sortDescriptor1,sortDescriptor2, nil];
            [fetchRequest setSortDescriptors:sortDescriptors];
            sectionKey=@"secretIdentity";
            break;
        }

        default:
            break;
    }
    
    
    _fetchedResultsController=[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:sectionKey cacheName:@"Hero"];
    
    _fetchedResultsController.delegate=self;
    
    return _fetchedResultsController;
}

#pragma mark - NSFetchedResultsControllerDelegate
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.heroTableView beginUpdates];
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.heroTableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.heroTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            
            break;
        case NSFetchedResultsChangeDelete:
            [self.heroTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            
        default:
            break;
    }
    
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.heroTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.heroTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
        case NSFetchedResultsChangeMove:
            break;
        default:
            break;
    }
    
}
#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    exit(-1);
}
#pragma mark - add Hero
- (IBAction)addHero:(id)sender {
    
    NSManagedObjectContext *managedObjectContext=[self.fetchedResultsController managedObjectContext];
    
    NSEntityDescription *entity=[[self.fetchedResultsController fetchRequest] entity];
    
    [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:managedObjectContext];
    
    NSError *error=nil;
    
    if (![managedObjectContext save:&error]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error saving entity" message:@"Error was:%@,qutting." delegate:self cancelButtonTitle:@"AW,NUTS" otherButtonTitles: nil];
        
        [alert show];
    }
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    self.addButton.enabled=!editing;
    
    [self.heroTableView setEditing:editing animated:animated];
}
@end
