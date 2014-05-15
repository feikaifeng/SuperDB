//
//  HeroDetailController.m
//  SuperDB
//
//  Created by feikaifeng on 14-4-30.
//  Copyright (c) 2014年 feikaifeng. All rights reserved.
//

#import "ManagedObjectController.h"
#import "SuperDBEditCell.h"
#import "ManagedObjectConfiguration.h"

@interface ManagedObjectController ()

//@property (strong,nonatomic) NSArray *sections;


@property (strong,nonatomic) UIBarButtonItem *saveButton;
@property (strong,nonatomic) UIBarButtonItem *backButton;
@property (strong,nonatomic) UIBarButtonItem *cancelButton;

-(void)save;
-(void)cancel;

-(void)updateDynamicSection:(BOOL)editing;
-(void)saveManagedObjectContext;
@end

@implementation ManagedObjectController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.saveButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    self.backButton=self.navigationItem.leftBarButtonItem;
    self.cancelButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{

    [self.tableView beginUpdates];
    
    [self updateDynamicSection:editing];
    
    [super setEditing:editing animated:animated];
    
    [self.tableView endUpdates];
    
    self.navigationItem.rightBarButtonItem=(editing)? self.saveButton:self.editButtonItem;
    self.navigationItem.leftBarButtonItem=(editing)? self.cancelButton:self.backButton;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return [self.config numberOfSections];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSInteger rowCount=[self.config numberOfRowsInSection:section];
    if ([self.config isDynamicSection:section]) {
        NSString *key=[self.config dynamicAttributeKeyForSection:section];
        NSSet *attributeSet=[self.managedObject mutableSetValueForKey:key];
        
        rowCount=(self.editing) ? attributeSet.count+1 : attributeSet.count;
    }
    
    return rowCount;

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return [self.config headerInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    NSString *cellClassName=[self.config cellClassnameForIndexPath:indexPath];
    
    SuperDBEditCell *cell = [tableView dequeueReusableCellWithIdentifier:cellClassName];
    
    if (cell==nil) {
        
        Class cellClass=NSClassFromString(cellClassName);
        cell=[cellClass alloc];
        
        cell=[cell initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellClassName];
        cell.hero=self.managedObject;
        
    }
    // Configure the cell...

    NSArray *values=[self.config valuesForIndexPath:indexPath];
    if (values!=nil) {
        [cell performSelector:@selector(setValues:) withObject:values];
    }

    cell.key=[self.config attributeKeyForIndexPath:indexPath];
    cell.label.text=[self.config labelForIndexForIndexPath:indexPath];

    if ([self.config isDynamicSection:[indexPath section]]) {
        NSString *key=[self.config attributeKeyForIndexPath:indexPath];
        NSMutableSet *relationshipSet=[self.managedObject mutableSetValueForKey:key];
        NSArray *relationshipArray=[relationshipSet allObjects];
        if ([indexPath row]!= relationshipArray.count) {
            NSManagedObject *relationshipObject=[relationshipArray objectAtIndex:indexPath.row];
            cell.value=[relationshipObject valueForKey:@"name"];
            cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
            cell.editingAccessoryType=UITableViewCellAccessoryDetailDisclosureButton;
        }
        else{
            cell.label.text=nil;
            cell.textField.text=@"Add New Power...";
        }
    }
    else{

        NSString *value=[[self.config rowForIndexPath:indexPath] objectForKey:@"value"];
        if (value !=nil) {
            cell.value=value;
            cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
            cell.editingAccessoryType=UITableViewCellAccessoryDetailDisclosureButton;
        }else{
            cell.value=[self.managedObject valueForKey:[self.config attributeKeyForIndexPath:indexPath]];
        }
    }
    
    return cell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCellEditingStyle editStyle=UITableViewCellEditingStyleNone;
    
    NSInteger section=[indexPath section];
    if ([self.config isDynamicSection:section]) {
        NSInteger rowNumber=[self tableView:self.tableView numberOfRowsInSection:section];
        if ([indexPath row]== rowNumber-1) {
            editStyle=UITableViewCellEditingStyleInsert;
        }else{
            editStyle=UITableViewCellEditingStyleDelete;
        }
        
    }
    
    return editStyle;

//    return UITableViewCellEditingStyleNone;
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
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else if (editingStyle==UITableViewCellEditingStyleInsert){
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        [tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
#pragma mark - (Private) Instance Methods
-(void)save{
    [self setEditing:NO animated:YES];
    
    for (SuperDBEditCell *cell in [self.tableView visibleCells]) {
        if ([cell isEditable]) {
            [self.managedObject setValue:[cell value] forKey:[cell key]];
        }
        
    }

    [self saveManagedObjectContext];
    
    [self.tableView reloadData];
}
-(void)cancel{
    [self setEditing:NO animated:YES];
}

-(void)updateDynamicSection:(BOOL)editing{
    for (NSInteger section=0; section< [self.config numberOfSections]; section ++) {
        if ([self.config isDynamicSection:section]) {
            NSIndexPath *indexPath;
            NSInteger row=[self tableView:self.tableView numberOfRowsInSection:section];
            
            if (editing) {
                indexPath=[NSIndexPath indexPathForRow:row inSection:section];
                [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }else{
                indexPath=[NSIndexPath indexPathForRow:row-1 inSection:section];
                [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
        }
    }
}

-(void)saveManagedObjectContext{
    NSError *error=nil;
    if (![self.managedObject.managedObjectContext save:&error]) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error saving entity", @"Error saving entity")
                                                      message:[NSString stringWithFormat:NSLocalizedString(@"Error was:%@,qutting.", @"Error was:%@,qutting."),[error localizedDescription]]
                                                     delegate:self
                                            cancelButtonTitle:NSLocalizedString(@"Aw,Nuts", @"Aw,Nuts")
                                            otherButtonTitles: nil];
        [alert show];
    }
}

-(NSManagedObject *)addRelationshipObjectForSection:(NSInteger)section{
    NSString *key=[self.config dynamicAttributeKeyForSection:section];
    
    NSMutableSet *relationshipSet=[self.managedObject mutableSetValueForKey:key];
    
    NSEntityDescription *entity=[self.managedObject entity];
    NSDictionary *relationships=[entity relationshipsByName];
    NSRelationshipDescription *destRelationship=[relationships objectForKey:key];
    NSEntityDescription *destEntiy=[destRelationship destinationEntity];
    
    NSManagedObject *relationshipObject=[NSEntityDescription insertNewObjectForEntityForName:[destEntiy name]
                                                                      inManagedObjectContext:self.managedObject.managedObjectContext];
    
    [relationshipSet addObject:relationshipObject];
    [self saveManagedObjectContext];
    
    return relationshipObject;
    
}

-(void)removeRelationshipObjectInIndexPath:(NSIndexPath *)indexPath{
    NSString *key=[self.config dynamicAttributeKeyForSection:indexPath.section];
    NSMutableSet *relationshipSet=[self.managedObject mutableSetValueForKey:key];
    
    NSManagedObject *relationshipObject=[[relationshipSet allObjects] objectAtIndex:indexPath.row];
    [relationshipSet removeObject:relationshipObject];
    [self saveManagedObjectContext];
}
@end
