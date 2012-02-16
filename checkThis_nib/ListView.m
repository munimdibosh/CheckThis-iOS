//
//  ListView.m
//  checkThis_nib
//
//  Created by ManGoes Mobile on 22/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ListView.h"

@implementation ListView;
@synthesize listNameLabel;
@synthesize moduleNameLabel;
@synthesize taskTable;
@synthesize listName;
/*
 MANUAL DEFINITION OF THE DELEGATES
 */
- (id <CallImagePickerDelegate>)delegate
{
    return delegate;
}
//Declare the setDelegate method
- (void)setDelegate:(id <CallImagePickerDelegate>)v
{
    delegate = v;
}
- (id <ListViewDelegate>)accessoryViewDelegate
{
    return accessoryViewDelegate;
}
//Declare the setDelegate method
- (void)setAccessoryViewDelegate:(id <ListViewDelegate>)v
{
    accessoryViewDelegate = v;
}


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
/*
 TABLE VIEW SPECIFIC METHODS.
 */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    Task *temp=[tasks objectAtIndex:[indexPath row]];
    NSString *text =temp.name;
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH -CELL_IMAGE_WIDTH, 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE_16] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2);
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
-(UITableViewCell* )createTableCellForActualList:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
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
    cell.textLabel.numberOfLines=0;
    [cell.textLabel setFont:[UIFont fontWithName:@"Marker Felt" size:FONT_SIZE_16]];
        
    cell.detailTextLabel.adjustsFontSizeToFitWidth=NO;
    cell.detailTextLabel.numberOfLines=0;
    [cell.detailTextLabel setFont:[UIFont fontWithName:@"Marker Felt" size:FONT_SIZE_IN_LIST]];
    
    if(shouldUpdateCell)
    {
        [cell.imageView setImage:[UIImage imageNamed:@"checkBox_checked.png"]];

        if(![temp hasSubtasks])
        {
            cell.detailTextLabel.text=[NSString stringWithFormat:@"Selected:%@",[selectedOption objectAtIndex:0]];
        }
        else
        {
            CustomAccessoryButton *detailsButton=[CustomAccessoryButton buttonWithType:UIButtonTypeCustom];
            detailsButton.titleLabel.textColor=[[UIColor alloc] initWithRed:(220/255.0) green:(203/255.0) blue:(154/255.0) alpha:1.0];
            detailsButton.frame=CGRectMake(0, 0,48,48);
            detailsButton.titleLabel.font=[UIFont fontWithName:@"Marker Felt" size:FONT_SIZE_18];
            [detailsButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [detailsButton setTitle:@">>" forState:UIControlStateNormal];
            [detailsButton addTarget:self action: @selector(detailsViewPressed:) forControlEvents:UIControlEventTouchUpInside];
            detailsButton.tag=indexPath.row;
            detailsButton.responses=selectedOption;
            cell.accessoryView=detailsButton;
            cell.detailTextLabel.text=@"Tap arrow to see details.";

            
        }
    }
    else
    {
        [cell.imageView setImage:[UIImage imageNamed:@"checkBox.png"]];
        if([temp hasSubtasks])
            cell.detailTextLabel.text=@"Subtasks has to be completed.";
        else
            cell.detailTextLabel.text=@"Option has to be selected.";


    }
    //optional
    //cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

//THIS UPDATES THE TABLE VIEW BASED ON USER INTERACTIONS.
-(void)updateCell:(int)n WithStatus:(NSString*)status WithOption:(NSMutableArray*)options
{
    NSIndexPath *index=[NSIndexPath indexPathForRow:n inSection:0];
    if([status isEqualToString:TASK_COMPLETED])
    {
        shouldUpdateCell=YES;
        selectedOption=options;
        [self.taskTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:index] withRowAnimation:UITableViewRowAnimationNone];
        selectedOption=nil;
        shouldUpdateCell=NO;
    }
}


//CREATES A TEXTFIELD ON UIALERTVIEW

- (UITextField*)createTextField:(CGRect)frame {
    UITextField *emailField = [[UITextField alloc] initWithFrame:frame];
    
    emailField.borderStyle = UITextBorderStyleBezel;
    emailField.textColor = [UIColor blackColor];
    emailField.textAlignment = UITextAlignmentCenter;
    emailField.font = [UIFont systemFontOfSize:14.0];
    emailField.placeholder = @"<enter email>";
    
    emailField.backgroundColor = [UIColor whiteColor];
    emailField.autocorrectionType = UITextAutocorrectionTypeNo;	// no auto correction support
    
    emailField.keyboardType = UIKeyboardTypeEmailAddress;	// use the default type input method (entire keyboard)
    emailField.returnKeyType = UIReturnKeyDone;
    emailField.clearButtonMode = UITextFieldViewModeWhileEditing;
    return emailField;
}
#pragma mark-details view action
-(IBAction)detailsViewPressed:(id)sender
{
    CustomAccessoryButton *button=(CustomAccessoryButton*)sender;
    NSLog(@"Inside detailsViewPressed.");
    [self.accessoryViewDelegate showAccessoryViewForSubtasksOfTask:button.tag WithOptionsSelected:[NSMutableArray arrayWithArray:button.responses]];
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
    /* 
     DATA LOADING.
     */
    listName=DataHolder.listName;
    list=[TestCase getTestList:listName];
    module=[list.modules objectAtIndex:0];
    tasks=module.tasks;
    taskTable.dataSource=self;
    taskTable.delegate=self;
    shouldUpdateCell=NO;
            
}
@end
