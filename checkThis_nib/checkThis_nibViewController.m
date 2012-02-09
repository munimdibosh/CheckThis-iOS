//
//  checkThis_nibViewController.m
//  checkThis_nib
//
//  Created by ManGoes Mobile on 20/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "checkThis_nibViewController.h"

@implementation checkThis_nibViewController
@synthesize viewEnhancer;
@synthesize imgPicker;
@synthesize overlayView;
@synthesize createButton;
@synthesize homeButton;
@synthesize helpButton;
@synthesize startButton;
@synthesize logoImage;
@synthesize containerView;
@synthesize listView;
@synthesize TableView;
@synthesize popUpQueue;

#pragma mark-TableView methods

/*
 MENU STYLE: LIST
 
 */
//table view specific methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [availableLists count];
}

/*
 CREATES CELL FOR LIST BASED MENU
 */
- (UITableViewCell*)createTableCellForListMenu:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil) 
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    
    cell.textLabel.text=[availableLists objectAtIndex:indexPath.row];
    cell.textLabel.adjustsFontSizeToFitWidth=NO;
    cell.textLabel.numberOfLines=0;
    [cell.textLabel setFont:[UIFont fontWithName:@"Marker Felt" size:FONT_SIZE_IN_MENU]];
    [cell.imageView setImage:[UIImage imageNamed:@"checkBox_checked.png"]];
    
    if([[availableLists objectAtIndex:indexPath.row] isEqualToString: @"Unavailable" ])
    {
        cell.textLabel.textColor=[[UIColor alloc] initWithRed:(173.0/255.0) green:(172.0/255.0) blue:(172.0/255.0) alpha:1.0];
        [cell.imageView setImage:[UIImage imageNamed:@"checkBox_unavailable.png"]];

    }
    return cell;
}

-(UITableViewCell* )tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self createTableCellForListMenu:tableView indexPath:indexPath];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //THE PROCEED BUTTON ON SOME LIST HAS BEEN TAPPED.
    //THE ACTUAL LIST IS ABOUT TO BE SHOWN.
    int row=indexPath.row;

    if(![[availableLists objectAtIndex:row] isEqualToString:@"Unavailable"])
    {
        DataHolder.listName=[availableLists objectAtIndex:row];
    
        [self loadActualListView];
    }
    
}

#pragma mark-ImagePicker methods

/*
 DELEGATE METHODS FOR IMAGE PICKER.
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
    
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

#pragma mark CallImagePickerDelegate methods

- (void)captureImage:(id)sender {
    NSLog(@"Here");
    [self showImagePicker];
}

#pragma mark ViewEnhancerDelegate methods

/*
 DELEGATE SENT FROM VIEW ENHANCER CLASS.
 */
-(void)optionSelected:(NSString *)option ForTask:(int)taskSerial WithSuperView:(UIView *)view
{
    Task *temp=[module.tasks objectAtIndex:taskSerial];
    if(![temp hasSubtasks])
    {
        [listView updateCell:taskSerial WithStatus:TASK_COMPLETED WithOption:option];
    }
    else
    {
        subtaskCounter++;
        //IF ALL THE SUBTASKS ARE OK THEN INFORM IT.
        if(subtaskCounter==[temp.subtasks count])
            [listView updateCell:taskSerial WithStatus:TASK_COMPLETED WithOption:SUBTASK_IDENTIFIER];

    }
    //
    if([self showSequencedPopoverFrom:view])
    {
        if([popUpQueue count]!=0)[popUpQueue removeAllObjects];
        //POP OVER OVERLAY SHOULD BE REMOVED.
        UIView *confirmationAlert=[viewEnhancer makeAlertFromMessage:@"Congratulations!This module is completed.You can start the next one when that gets uploaded."];
        [overlayView insertSubview:confirmationAlert aboveSubview:view];
        [self insertView:confirmationAlert AfterKickingOutViewFromTop:view WithDelay:0.5];
        moduleCompleted=YES;
    }
        
}

/*
 CALLED WHEN AN ALERT IS DISPLAYED AND NEEDS TO BE CLOSED.
 */

-(void)itemTapped:(id)sender
{
    UIView *viewItem=(UIView*)sender;
    if(viewItem.tag==OVERLAY_BUTTON_TAG)
    {
        //OVERLAY SHOULD BE REMOVED NOW.
        [self dismissAlert];
        
    }
}

/*
 THIS ACTION OPENS UP AN IMAGE PICKER.THIS IS CALLED FROM ONE OF SUBVIEWS VIA DELEGATE.CHECKS IF CAMERA IS AVAILABLE.
 */
-(void)showImagePicker
{
    self.imgPicker = [[UIImagePickerController alloc] init];
    self.imgPicker.delegate = self;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {  
        self.imgPicker.sourceType =UIImagePickerControllerSourceTypeCamera;
        [self.imgPicker setShowsCameraControls:YES];
        self.imgPicker.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:
         UIImagePickerControllerSourceTypeCamera];
        self.imgPicker.allowsEditing=NO;


    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Not Supported!" message:@"Sorry,you don't have a camera!Select one from gallery." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        self.imgPicker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
        self.imgPicker.mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:
                                   UIImagePickerControllerSourceTypePhotoLibrary];
        self.imgPicker.allowsEditing=YES;



    }
    self.imgPicker.wantsFullScreenLayout = YES;
    [self presentModalViewController:self.imgPicker animated:YES];
}



/*
 LOGO ANIMATION AT START
 
 */

- (void)fadeOutLogo:(float)durationInSecond {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:durationInSecond];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    logoImage.alpha = 0.0f;
    
    [UIView commitAnimations];
}
/*
 Show the list and create option as soon as logo fades out
 */
- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context 
{
    if(animationType==1)
    {
        TableView.hidden= NO;
        createButton.hidden=NO;
        homeButton.hidden=NO;
        homeButton.enabled=NO;
        helpButton.hidden=NO;
    }
    if(animationType==2)
    {
        
        
    }
}
//SNATCHES OLD VIEW AT LEFT AND ANOTHER ENTERS FROM RIGHT.

-(void)insertView:(UIView*)newView AfterKickingOutView:(UIView*)oldView WithDelay:(float)durationInSecond
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:durationInSecond];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    float y=oldView.center.y;
    CGPoint oldViewCenter=oldView.center;
    oldView.center=CGPointMake(-320,y);
    newView.center=oldViewCenter;
    
    [UIView commitAnimations];
    
    
}

//OPPOSITE DIRECTION OF THE PREVIOUS ANIM
-(void)insertView:(UIView*)newView AfterPullingOutView:(UIView*)oldView WithDelay:(float)durationInSecond
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:durationInSecond];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    float y=oldView.center.y;
    CGPoint oldViewCenter=oldView.center;
    oldView.center=CGPointMake(600,y);
    newView.center=oldViewCenter;
    
    [UIView commitAnimations];
    
    
}
//SNATCHES OLD VIEW AT TOP AND ANOTHER ENTERS FROM BOTTOM.

-(void)insertView:(UIView*)newView AfterKickingOutViewFromTop:(UIView*)oldView WithDelay:(float)durationInSecond
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:durationInSecond];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    float x=oldView.center.x;
    CGPoint oldViewCenter=oldView.center;
    newView.center=CGPointMake(oldViewCenter.x, oldViewCenter.y+300);
    oldView.center=CGPointMake(x,-500);
    newView.center=oldViewCenter;
    
    [UIView commitAnimations];
}


/*
 CREATES THE POP OVER QUEUE TO SHOW UP FOR TASKS.
 */
/*
 CREATES A QUEUE OF TASK POP UPS!
 */
- (void)initPopUpQueue {
    int I=0;
    Task *task;
    Module *tempModule=[list.modules objectAtIndex:0];
    NSArray *tasks=tempModule.tasks;
    
    while(I<[tasks count])
    {
        task=[tasks objectAtIndex:I];
        if(![task hasSubtasks])
        {
            [popUpQueue addObject:[viewEnhancer makeTaskViewWithTitle:module.name ForTask:task WithSerial:I]];
            task=nil;
        }
        else
        {
            SubTask *subtask;
            int subtaskCount=[task.subtasks count];
            for(int K=0;K<subtaskCount;K++)
            {
                subtask=[task.subtasks objectAtIndex:K];
                [popUpQueue addObject:[viewEnhancer makeSubTaskViewWithTitle:module.name OfTask:task.name WithSerial:I ForSubTask:subtask]];
                subtask=nil;
            }
        }
        I++;
    }
    NSLog(@"Popup queue initialized:%d",[popUpQueue count]);
}
/*
 SEQUENTIALLY SHOWS THE POP OVERS.
 */

- (BOOL)showSequencedPopoverFrom:(UIView *)sourceView {
    
    
    if ( !sourceView ) {
        [overlayView addSubview:[popUpQueue objectAtIndex:0]];
    }
    else {
        NSInteger index = [popUpQueue indexOfObject:sourceView];
        
        
        int count=[popUpQueue count];
        NSLog(@"Before showing the alert and increment:%d",index);
        
        index++;
        
        NSLog(@"After increment:%d",index);
        
        if (index<count ) 
        {
            [overlayView insertSubview:[popUpQueue objectAtIndex:index] aboveSubview:sourceView];
            [self insertView:[popUpQueue objectAtIndex:index] AfterKickingOutViewFromTop:sourceView WithDelay:1.0];
            NSLog(@"After showing the pop up:%d",index);
        }
        if(index==count)
        {
            return YES;            
        }
        
    }
    return NO;
}

-(int)startInteraction
{
    if(!moduleCompleted)
    {
        [self initPopUpQueue];
        [self initAlertOverlay];
        [self.view addSubview:overlayView];
        [self showSequencedPopoverFrom:nil];
    }
    else
        [self showAlert:@"This module is already completed."];
    
    return LIST_COMPLETED_SUCCESSFULLY;
}







/*
 CREATES THE AVAILABLE LIST MENU WITH PROPER DATA AND LOOK.
 */
- (void)initPrimaryLookAndData {
    
    
    //setting delegate and data source for table view
    
    TableView.delegate=self;
    TableView.dataSource=self;
        
    //SET ALL THE BUTTONS TO BE HIDDEN AT FIRST.
    
    TableView.hidden=YES;
    createButton.hidden=YES;
    homeButton.hidden=YES;
    startButton.hidden=YES;
    helpButton.hidden=YES;
    
    //ViewEnhancer IS RESPONSIBLE FOR ALL CUSTOM UI DESIGNS APPPLIED.
    viewEnhancer=[[ViewEnhancer alloc] init];
    viewEnhancer.delegate=self;
    //
    currentView=[[UIView alloc] init];
    prevView=[[UIView alloc] init];
    /*
     INITS POP UP HOLDER
     */
    if ( !popUpQueue) {
        popUpQueue = [[NSMutableArray alloc] init];
    }
    //SET THE PAPER LOOK

    [viewEnhancer setThePaperLookForView:self.containerView]; 
    
    //CREATING THE STATIC ARRAY OF AVAILABLE LISTS.
    
    @try {
        availableLists=[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:@"Surgical",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",nil]];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Error in view did load method");
    }
    //GET THE LIST.
    list=[TestCase getTestList:@"Surgical"];
    module=[list.modules objectAtIndex:0];
    //INIT THE subtaskcounter
    subtaskCounter=0;
    //
    moduleCompleted=NO;
}

//THIS METHOD MAKES THE ACTUAL LIST VIEW FROM NIB AND SAVES THAT IN LISTVIEW OBJECT.
- (void)createListView {
    ListView *newView = [[ListView alloc] initWithFrame:CGRectMake(containerView.frame.origin.x+340,containerView.frame.origin.y,containerView.frame.size.width,containerView.frame.size.height)];
    [viewEnhancer setThePaperLookForView:newView];
    //SETTING THE WIDTH AND HEIGHT FOR LISTVIEW.
    CGPoint pos=newView.taskTable.frame.origin;
    newView.taskTable.frame=CGRectMake(pos.x,pos.y, 300, 342);

    [self.view insertSubview: newView aboveSubview: containerView];
    
    self.listView = newView;
    //SETTING THE DELEGATE FOR LISTVIEW.
    listView.delegate=self;

    

}

/*
 LOADS THE ACTUAL CHECK LIST ON BOARD WHEN THAT LIST IS CLICKED FROM
 AVAILABLE LIST MENU.
 */

- (void)loadActualListView {

    if(homeButton.enabled==NO)homeButton.enabled=YES;
    if(startButton.hidden==YES)startButton.hidden=NO;
    
    //CREATE THE LIST VIEW WITH PROPER LIST
    
    [self createListView];
    //
    animationType=2;
    [self insertView:listView AfterKickingOutView:containerView WithDelay:0.3];
}

//CALL THIS METHOD BEFORE CREATING AN ALERT 
//MANUAL CALL IS NOT ENCOURAGED AS IT"S GETTING CALLED IN showAlert method.
-(void)initAlertOverlay
{
    /*
     THIS OVERLAYED VIEW IS THE PROTECTOR OF ANY INTERACTION WITH THE
     BACKGROUND VIEW ELEMENTS WHEN AN ALERT IS SHOWN.
     */
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    overlayView=[[UIView alloc]initWithFrame:screenSize];
    overlayView.backgroundColor=[[UIColor alloc] initWithRed:(255.0/255.0) green:(255.0/255.0) blue:(255.0/255.0) alpha:0.35];
    
}


//CALL THIS METHOD DURING DISMISSING AN ALERT

- (void)dismissAlert{
    //EMPTIED THE OVERLAY VIEW
    for(UIView* view in overlayView.subviews)
        [view removeFromSuperview];
    //AT LAST REMOVE THE OVERLAY.
    [overlayView removeFromSuperview];
    overlayView=nil;
}


/*
 ACTION GROUND.THIS PLACE IS WHERE ALL ACTION METHODS ARE PLACED.
 */

- (void)showAlert:(NSString *)msg {
    //CREATE AN ALERT WITH THE MESSAGE AND PASS IT ON TO OVERLAYVIEW.
    [self initAlertOverlay];
    [overlayView addSubview:[viewEnhancer makeAlertFromMessage:msg]];
    [self.view addSubview:overlayView];
}

/*
 BUTTON TAPPED.HANDLES ACTION FOR WHEN ANY OF THE BUTTON GETS PRESSED BASED ON THEIR TAG.
 */

-(IBAction)buttonTapped:(id)sender
{
    NSInteger tag=[sender tag];
    if(tag==HOME_BUTTON_TAG)
    {
        //HOME BUTTON GOT PRESSED
        [self insertView:containerView AfterPullingOutView:listView WithDelay:0.3];
        listView=nil;
        if(homeButton.enabled==YES)homeButton.enabled=NO;
        if(startButton.hidden==NO)startButton.hidden=YES;
        if(moduleCompleted)moduleCompleted=NO;
        
    }
    else if(tag==CREATE_BUTTON_TAG)
    {
    
        //CREATE BUTTON HAS BEEN PRESSED
        NSString *msg=@"This feature is currently under development.\nYou will be notified when an upgrade is available.";
        [self showAlert:msg];
        
    }
    else if(tag==START_BUTTON_TAG)
    {
        //THE PLAY BUTTON GOT PRESSED.
        @try {
            [self startInteraction];
        }
        @catch (NSException *exception) {
            NSLog(@"exception: %@",exception);
        }
    }
    else if(tag==HELP_BUTTON_TAG)
    {
        
        NSString *msg=@"This is pretty simple at this moment.Just tap a list,when you see the list,tap 'play button' to start completing the tasks in the list.";
        [self showAlert:msg];

    }
}

- (void)setTagForVisibleButtons {
    //
    homeButton.tag=HOME_BUTTON_TAG;
    createButton.tag=CREATE_BUTTON_TAG;
    startButton.tag=START_BUTTON_TAG;
    helpButton.tag=HELP_BUTTON_TAG;
}




#pragma mark - View lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTagForVisibleButtons];
    /*
     KEEP THE MENU LIST BUT DONT LOAD ANY SPECIFIC LIST.
     */
    [self initPrimaryLookAndData];
    
    //fades the logo out
    animationType=1;
    
    [self fadeOutLogo:5.0]; 
}


- (void)viewDidUnload
{

    createButton = nil;
    overlayView=nil;
    containerView=nil;
    TableView=nil;
    logoImage=nil;
    listView=nil;
    homeButton = nil;
    helpButton = nil;
    [self setListView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

/*MANUALLY SET UP AS WAS NOT SET IN INFO.PLIST BEFORE.*/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
