//
//  HeroDetailController.m
//  SuperDB
//
//  Created by feikaifeng on 14-4-30.
//  Copyright (c) 2014年 feikaifeng. All rights reserved.
//

#import "HeroDetailController.h"
#import "SuperDBEditCell.h"

@interface HeroDetailController ()

@property (strong,nonatomic) NSArray *sections;
@property (strong,nonatomic) UIBarButtonItem *saveButton;
@property (strong,nonatomic) UIBarButtonItem *backButton;
@property (strong,nonatomic) UIBarButtonItem *cancelButton;

-(void)save;
-(void)cancel;

@end

@implementation HeroDetailController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.saveButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
    
    self.backButton=self.navigationItem.leftBarButtonItem;
    self.cancelButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    NSString *path=[[NSBundle mainBundle] pathForResource:@"HeroDetailConfiguration" ofType:@"plist"];
    NSDictionary *plist=[NSDictionary dictionaryWithContentsOfFile:path];
    self.sections=[plist valueForKey:@"sections"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    
    self.navigationItem.rightBarButtonItem=(editing)? self.saveButton:self.editButtonItem;
    self.navigationItem.leftBarButtonItem=(editing)? self.cancelButton:self.backButton;
}
#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger sectionIndex=[indexPath section];
    NSUInteger rowIndex=[indexPath row];
    
    NSDictionary *section=self.sections[sectionIndex];
    NSArray *rows=[section valueForKey:@"rows"];
    NSDictionary *row=rows[rowIndex];
    
    NSString *cellClassName=[row valueForKey:@"class"];
    
    
    SuperDBEditCell *cell = [tableView dequeueReusableCellWithIdentifier:cellClassName];
    
    if (cell==nil) {
        
        Class cellClass=NSClassFromString(cellClassName);
        cell=[cellClass alloc];
        
        cell=[cell initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellClassName];
        cell.hero=self.hero;
        
    }
    // Configure the cell...

    NSArray *values=[row valueForKey:@"values"];
    if (values!=nil) {
        [cell performSelector:@selector(setValues:) withObject:values];
    }
    

    cell.key=[row valueForKey:@"key"];
    cell.label.text=[row valueForKey:@"label"];
    cell.textField.text=[[self.hero valueForKey:[row valueForKey:@"key"]] description];
    
    
    return cell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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
            [self.hero setValue:[cell value] forKey:[cell key]];
        }
        
    }
    
    NSError *error=nil;
    if (![self.hero.managedObjectContext save:&error]) {
        NSLog(@"Error saving:%@",[error localizedDescription]);
    }
    
    [self.tableView reloadData];
}
-(void)cancel{
    [self setEditing:NO animated:YES];
}
@end
