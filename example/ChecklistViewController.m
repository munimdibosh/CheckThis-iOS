//
//  ChecklistViewController.m
//  example
//
//  Created by ManGoes Mobile on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChecklistViewController.h"

@implementation ChecklistViewController

@synthesize listNameLabel,moduleNameLabel,list,companyIconImage,listPageView,TableView,tasks,subtasks,module;
//table view specific methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tasks count];
}

-(UITableViewCell* )tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil) 
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    //setting the properties for cell
    Task *temp=[tasks objectAtIndex:indexPath.row];
    cell.textLabel.text=temp.name;
    cell.textLabel.adjustsFontSizeToFitWidth=NO;
    cell.textLabel.numberOfLines=2;
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    //
    if([temp hasSubtasks])
        cell.detailTextLabel.text=@"It has subtasks";
    else
        cell.detailTextLabel.text=@"It has options";

    cell.detailTextLabel.adjustsFontSizeToFitWidth=NO;
    cell.detailTextLabel.numberOfLines=1;
    [cell.detailTextLabel setFont:[UIFont italicSystemFontOfSize:12]];
    [cell.imageView setImage:[UIImage imageNamed:@"checkBox.png"]];
    //optional
    //cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
    

}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



//this is a method to create an example alert view
/*
-(void)newLocalScore {
	UIAlertView* dialog = [[UIAlertView alloc] init];
	[dialog setDelegate:self];
	[dialog setTitle:@"Online Access"];
	[dialog setMessage:@"Do you want to connect to the online ranking?"];
	[dialog addButtonWithTitle:@"Yes"];
	[dialog addButtonWithTitle:@"No"];
    [dialog addButtonWithTitle:@"Maybe"];
	[dialog show];
}

- (void) alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex==0) {
        //do stuff
    }
}
*/
#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
/*
- (void)loadView
{
    
    
}
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    //set drop shadow for list page
    listPageView.layer.shadowColor=[UIColor blackColor].CGColor;
    listPageView.layer.shadowOpacity=1.0;
    listPageView.layer.shadowRadius=5.0;
    listPageView.layer.shadowOffset=CGSizeMake(0,4); 
    //set the table view delegate and source to self
    TableView.delegate=self;
    TableView.dataSource=self;
    TableView.rowHeight=50.0;
    //set data source for the table
    list=[TestCase getTestList];
    module=[list.modules objectAtIndex:0];
    tasks=module.tasks;
        
}

-(void)initDataSource
{
    
}

- (void)viewDidUnload
{
    listNameLabel = nil;
    moduleNameLabel = nil;
    companyIconImage = nil;
    listPageView = nil;
    TableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
