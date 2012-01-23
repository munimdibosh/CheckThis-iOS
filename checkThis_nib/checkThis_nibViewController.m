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
@synthesize logoImage;
@synthesize containerView;
@synthesize TableView;
@synthesize listView;

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
    return cell;
}

-(UITableViewCell* )tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [self createTableCellForListMenu:tableView indexPath:indexPath];
    
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
    }
    if(animationType==2)
    {
        [containerView removeFromSuperview];

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
    //
    //at first the page control should be invisible
    TableView.hidden=YES;
    createButton.hidden=YES;
    homeButton.hidden=YES;
    homeButton.tag=3;
    [self setThePaperLookForView:self.containerView]; 
    //
    //
    array_offset=0;
    //unit test
    //NSLog(@"HERE");
    @try {
        availableLists=[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:@"Surgical",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",nil]];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Error in view did load method");
    }
}

/*
 LOADS THE ACTUAL CHECK LIST ON BOARD WHEN THAT LIST IS CLICKED FROM
 AVAILABLE LIST MENU.
 */

- (void)loadActualListView {
    
    NSArray *xibviews = [[NSBundle mainBundle] loadNibNamed: @"ListView" owner:listView options: NULL];
    ListView *newView = [xibviews objectAtIndex: 0];
    newView.frame = CGRectMake(containerView.frame.origin.x+340,containerView.frame.origin.y,containerView.frame.size.width,containerView.frame.size.height);
    [self setThePaperLookForView:newView];
    [self.view insertSubview: newView aboveSubview: containerView];
    self.listView = newView;
    //
    homeButton.hidden=NO;
    //
    animationType=2;
    [self insertView:newView AfterKickingOutView:containerView WithDelay:0.3];
    /*
     INITIATE THE DATA FOR THE LIST.
     */
    
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
    UIAlertView *alert=[[UIAlertView alloc] initWithFrame:CGRectMake( width-300,height-340,280,200)];
    [self setThePaperLookForView:alert];
    //
    UILabel *messageLabel=[[UILabel alloc] initWithFrame:CGRectMake(20,30,240,120)];
    messageLabel.text=msg;
    messageLabel.backgroundColor=[UIColor clearColor];
    messageLabel.numberOfLines=5;
    messageLabel.font=markerFont;
    //
    UIButton *okButton=[UIButton buttonWithType:UIButtonTypeCustom];
    okButton.titleLabel.textColor=[[UIColor alloc] initWithRed:(220/255.0) green:(203/255.0) blue:(154/255.0) alpha:1.0];
    okButton.titleLabel.font=[UIFont fontWithName:@"Marker Felt" size:15];
    okButton.frame=CGRectMake(95, 162,90, 29);
    [okButton setBackgroundImage:[UIImage imageNamed:@"alert_button_bg.png"] forState:UIControlStateNormal];
    [okButton setTitle:@"Ok,Thanks!" forState:UIControlStateNormal];
    [okButton setTag:2];
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
    if(tag==2)
    {
        //THE DISMISS BUTTON FOR ALERT VIEW HAS BEEN PRESSED.
        [overlayView removeFromSuperview];
    }
    else if(tag==3)
    {
        
    }
    else
    {
        
        //THE PROCEED BUTTON ON SOME LIST HAS BEEN TAPPED.
        //THE ACTUAL LIST IS ABOUT TO BE SHOWN.
        [self loadActualListView];
        

    }
}
- (IBAction)showAlert:(id)sender{
    NSString *msg=@"This feature is currently under development.You will be notified when an upgrade is available.";
    [self makeAlertFromMessage:msg];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end
