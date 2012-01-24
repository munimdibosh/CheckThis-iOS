//
//  ListView.m
//  checkThis_nib
//
//  Created by ManGoes Mobile on 22/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ListView.h"

@implementation ListView

@synthesize listNameLabel;
@synthesize moduleNameLabel;
@synthesize taskTable;
@synthesize listName;

- (id)initWithFrame:(CGRect)frame
{
        
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"ListView"
                                                              owner:nil
                                                            options:nil];
        
        if ([arrayOfViews count] < 1){
                        return nil;
        }
        
        ListView *newView = [arrayOfViews objectAtIndex:0];
        [newView setFrame:frame];
        self = newView;
        
        return self;
}

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
    return [self createTableCellForActualList:tableView indexPath:indexPath];
    
    
}


- (UITableViewCell*)createTableCellForActualList:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
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
    [cell.textLabel setFont:[UIFont fontWithName:@"Marker Felt" size:15]];
    //
    if([temp hasSubtasks])
        cell.detailTextLabel.text=@"Subtasks has to be completed.";
    else
        cell.detailTextLabel.text=@"Option has to be selected.";
    
    cell.detailTextLabel.adjustsFontSizeToFitWidth=NO;
    cell.detailTextLabel.numberOfLines=1;
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"Marker Felt" size:12]];
    [cell.imageView setImage:[UIImage imageNamed:@"checkBox.png"]];
    //optional
    //cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

-(int)startInteraction
{
    [[[UIAlertView alloc] initWithTitle:@"Not implemented!" message:@"This feature is under development" delegate:self cancelButtonTitle:@"Get lost!" otherButtonTitles:nil, nil] show];
        return LIST_COMPLETED_SUCCESSFULLY;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // YES CLICKED
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)awakeFromNib
{
    listName=DataHolder.listName;
    list=[TestCase getTestList:listName];
    module=[list.modules objectAtIndex:0];
    tasks=module.tasks;
    taskTable.dataSource=self;
    taskTable.delegate=self;

    
}
@end
