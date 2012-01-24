//
//  checkThis_nibViewController.m
//  checkThis_nib
//
//  Created by ManGoes Mobile on 20/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "checkThis_nibViewController.h"

@implementation checkThis_nibViewController

@synthesize overlayView;
@synthesize createButton;
@synthesize homeButton;
@synthesize helpButton;
@synthesize startButton;
@synthesize logoImage;
@synthesize containerView;
@synthesize listView;
@synthesize TableView;

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
    cell.textLabel.numberOfLines=2;
    [cell.textLabel setFont:[UIFont fontWithName:@"Marker Felt" size:20]];
    [cell.imageView setImage:[UIImage imageNamed:@"checkBox.png"]];
    /*
     COMMENTING OUT THE BUTTON FUNCTIONALITY ON ANY TABLE VIEW CELL.
    //
    UIButton *aButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aButton.backgroundColor=[UIColor clearColor];
    [aButton setFrame:CGRectMake(0, 0, 32,20)];
    if([[availableLists objectAtIndex:indexPath.row] isEqualToString: @"Unavailable" ])
    {
        [aButton setImage:[UIImage imageNamed:@"proceed_arrow_gray.png"] forState:UIControlStateNormal];
        aButton.enabled=NO;
        cell.textLabel.textColor=[[UIColor alloc] initWithRed:(173.0/255.0) green:(172.0/255.0) blue:(172.0/255.0) alpha:1.0];
    }
    else
    {
        [aButton setImage:[UIImage imageNamed:@"proceed_arrow.png"] forState:UIControlStateNormal];
        
        //action that corresponds to tap
        [aButton addTarget:self action: @selector(buttonTapped:)forControlEvents:UIControlEventTouchUpInside];
        [aButton setTag:indexPath.row];
        [aButton setImage:[UIImage imageNamed:@"proceed_arrow_tap.png"] forState:UIControlStateSelected];
        aButton.enabled=YES;
    }
    cell.accessoryView = aButton;
     
    //optional
    //cell.accessoryType=UITableViewCellAccessoryDetailDisclosureButton;
     */
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
    DataHolder.listName=[availableLists objectAtIndex:row];
    
    NSLog(@"Inside method tap for cell.Before load.");
    
    [self loadActualListView];
    
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




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


/*
 SETS THE PAPER LOOK FOR VIEW ON BOARD.
 */

- (void)setThePaperLookForView:(UIView*)view{
    
    //programmatically set image for the paper view    
    UIColor *bgImg=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"paper.png"]];
    view.backgroundColor=bgImg;
    //set shadow of the page
    view.layer.shadowColor=[UIColor blackColor].CGColor;
    view.layer.shadowOpacity=1.0;
    view.layer.shadowRadius=5.0;
    view.layer.shadowOffset=CGSizeMake(0,4);
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
    
    //SET THE PAPER LOOK
    
    [self setThePaperLookForView:self.containerView]; 
    
    //CREATING THE STATIC ARRAY OF AVAILABLE LISTS.
    
    @try {
        availableLists=[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:@"Surgical",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",nil]];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Error in view did load method");
    }
}

//THIS METHOD MAKES THE ACTUAL LIST VIEW FROM NIB AND SAVES THAT IN LISTVIEW OBJECT.
- (void)createListView {
    ListView *newView = [[ListView alloc] initWithFrame:CGRectMake(containerView.frame.origin.x+340,containerView.frame.origin.y,containerView.frame.size.width,containerView.frame.size.height)];
    [self setThePaperLookForView:newView];

    [self.view insertSubview: newView aboveSubview: containerView];
    
    self.listView = newView;
    
    NSLog(@"Inside creating list view.After creation.");

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
/*
 CREATES A CUSTOM PAPER FEEL ALERT VIEW.
 */
- (void)makeAlertFromMessage:(NSString*) msg {
    
    CGRect screenSize = [[UIScreen mainScreen] bounds];
    float width=screenSize.size.width;
    float height=screenSize.size.height;
    UIFont *markerFont=[UIFont fontWithName:@"Marker Felt" size:20];
    /*
     THIS OVERLAYED VIEW IS THE PROTECTOR OF ANY INTERACTION WITH THE
     BACKGROUND VIEW ELEMENTS.
     */
    overlayView=[[UIView alloc]initWithFrame:screenSize];
    overlayView.backgroundColor=[[UIColor alloc] initWithRed:(255.0/255.0) green:(255.0/255.0) blue:(255.0/255.0) alpha:0.35];
    [self.view addSubview:overlayView];
    UIView *alert=[[UIAlertView alloc] initWithFrame:CGRectMake( width-300,height-340,280,200)];
    [self setThePaperLookForView:alert];
    //
    UILabel *messageLabel=[[UILabel alloc] initWithFrame:CGRectMake(20,20,240,130)];
    messageLabel.text=msg;
    messageLabel.backgroundColor=[UIColor clearColor];
    messageLabel.numberOfLines=5;
    messageLabel.font=markerFont;
    messageLabel.adjustsFontSizeToFitWidth=YES;
    //
    UIButton *okButton=[UIButton buttonWithType:UIButtonTypeCustom];
    okButton.titleLabel.textColor=[[UIColor alloc] initWithRed:(220/255.0) green:(203/255.0) blue:(154/255.0) alpha:1.0];
    okButton.titleLabel.font=[UIFont fontWithName:@"Marker Felt" size:15];
    okButton.frame=CGRectMake(95, 162,90, 29);
    [okButton setBackgroundImage:[UIImage imageNamed:@"alert_button_bg.png"] forState:UIControlStateNormal];
    [okButton setTitle:@"Ok,Thanks!" forState:UIControlStateNormal];
    [okButton setTag:OVERLAY_BUTTON_TAG];
    [okButton addTarget:self action: @selector(buttonTapped:)forControlEvents:UIControlEventTouchUpInside];
    [alert addSubview:messageLabel];
    [alert addSubview:okButton];
    [overlayView addSubview:alert];
}

/*
 ACTION GROUND.THIS PLACE IS WHERE ALL ACTION METHODS ARE PLACED.
 */
/*
 BUTTON TAPPED.HANDLES ACTION FOR WHEN ANY OF THE BUTTON GETS PRESSED BASED ON THEIR TAG.
 */


-(IBAction)buttonTapped:(id)sender
{
    NSInteger tag=[sender tag];
    if(tag==OVERLAY_BUTTON_TAG)
    {
        //THE DISMISS BUTTON FOR ALERT VIEW HAS BEEN PRESSED.
        [overlayView removeFromSuperview];
    }
    else if(tag==HOME_BUTTON_TAG)
    {
        //HOME BUTTON GOT PRESSED
        [self insertView:containerView AfterPullingOutView:listView WithDelay:0.3];
        if(homeButton.enabled==YES)homeButton.enabled=NO;
        if(startButton.hidden==NO)startButton.hidden=YES;
        
    }
    else if(tag==CREATE_BUTTON_TAG)
    {
        //CREATE BUTTON HAS BEEN PRESSED
        NSString *msg=@"This feature is currently under development.You will be notified when an upgrade is available.";
        [self makeAlertFromMessage:msg];
    }
    else if(tag==START_BUTTON_TAG)
    {
        //THE PLAY BUTTON GOT PRESSED.
        [listView startInteraction];
    }
    else if(tag==HELP_BUTTON_TAG)
    {
        
        NSString *msg=@"This is pretty simple at this moment.Just tap a list,when you see the list,tap 'play button' to start completing the tasks in the list.";
        [self makeAlertFromMessage:msg];
        

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

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
