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
@synthesize playButton,forwardButton,backwardButton,optionsView;

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
    if(!startButton.isEnabled)
    {
        startButton.enabled=YES;
    }

    if(![[availableLists objectAtIndex:row] isEqualToString:@"Unavailable"])
    {
        DataHolder.listName=[availableLists objectAtIndex:row];
        DataHolder.list=[TestCase getTestList:DataHolder.listName];
        [self loadActualListView];
    }
    
}

#pragma mark-ImagePicker methods(BASE IMAGE PICKER)

/*
 DELEGATE METHODS FOR BASE IMAGE PICKER.
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
    
    [[picker parentViewController] dismissModalViewControllerAnimated:YES];
}

#pragma mark CallImagePickerDelegate methods(CALLED FROM LISTVIEW AS THAT'S CALL THE IMAGE PICKER)

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
        temp.responses=[NSMutableArray arrayWithObject:option];
        //
        [listView updateCell:taskSerial WithStatus:TASK_COMPLETED];
    }
    else
    {
        //[responseArray addObject:option];
        //
        SubTask *st=[temp.subtasks objectAtIndex:subtaskCounter];
        st.responses=[NSMutableArray arrayWithObject:option];
        //
        subtaskCounter++;
        //IF ALL THE SUBTASKS ARE OK THEN INFORM IT.
        if(subtaskCounter==[temp.subtasks count])
        {
            NSLog(@"Subtasks completed");
            NSLog(@"%d",taskSerial);
            [listView updateCell:taskSerial WithStatus:TASK_COMPLETED];
            //SET SUBTASK COUNTER TO 0 AGAIN.
            subtaskCounter=0;
        }

    }
    //
    if([self showSequencedPopoverFrom:view])
    {
        if([popUpQueue count]!=0)[popUpQueue removeAllObjects];
        //POP OVER OVERLAY SHOULD BE REMOVED.
        UIView *confirmationAlert=[viewEnhancer makeAlertFromMessage:@"Congratulations!This module is completed." WithButtonTitle:@"Ok,Thanks."];
        [overlayView insertSubview:confirmationAlert aboveSubview:view];
        [self insertView:confirmationAlert AfterKickingOutViewFromTop:view WithDelay:0.5];
        [self setModuleValidity:module To:YES];
        if([DataHolder.list isCompleted])
        {
            playButton.enabled=NO;
            [self setEnableButtonsInPopUp:YES];
        }
        else
        {
            [self nextModule];
        }
    }
            
}
#pragma mark-ListViewDelegate Methods
-(void)showAccessoryViewForSubtasksOfTask:(int)serial
{
    NSLog(@"Task-%d",serial);
    Task *temp=[module.tasks objectAtIndex:serial];
    int i=0;
    NSMutableString *string=[[NSMutableString alloc] init];
    for(SubTask *st in temp.subtasks)
    {
        NSString *msg=[NSString stringWithFormat:@"-%@\n\tSelected:\n%@",st.name,[st.responses objectAtIndex:0]];
        [string appendFormat:@"%@\n",msg];
        i++;
    }
    [self showAlertWithTitle:temp.name AndMessage:string WithAlignment:UITextAlignmentLeft];
    
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
-(BOOL)isNextValid
{
    int temp=DataHolder.moduleNumber+1;
    if([DataHolder.list isModuleAvailable:temp])
        return YES;
    else
        return NO;
}
-(BOOL)isBackValid
{
    int temp=DataHolder.moduleNumber-1;
    if(temp<0)
        return NO;
    else
        return YES;
}
/*
 LOADS NEXT MODULE
 */
- (void)nextModule {
    int temp=DataHolder.moduleNumber+1;
    if([DataHolder.list isModuleAvailable:temp])
    {
        DataHolder.moduleNumber=temp;
        module=[DataHolder.list.modules objectAtIndex:DataHolder.moduleNumber];
        [listView updateCellsWithStatus:TASK_COMPLETED];
    }
}
-(void)backModule
{   
    int temp=DataHolder.moduleNumber-1;

    if(temp>=0)
    {
        DataHolder.moduleNumber=temp;
        module=[DataHolder.list.modules objectAtIndex:DataHolder.moduleNumber];
        [listView updateCellsWithStatus:TASK_COMPLETED];
    }

}
/*
 POP UP ANIMATION
 */

- (void)popUpAnimForView:(UIView*)view {
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [self.view addSubview:view];
    
    [UIView animateWithDuration:0.3/2.5 animations:^{
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1,1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/3 animations:^{
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/3 animations:^{
                view.transform = CGAffineTransformIdentity;                            
            }];
        }];
    }];
    
}

- (void)popUpOutAnimForView:(UIView*)view {
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
    
    
    
    [UIView animateWithDuration:0.2/4 animations:
     ^{
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.7,0.7);
    } completion:^(BOOL finished) 
    {
        [UIView animateWithDuration:0.2/4.5 animations:
         ^{
            view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.3,0.3);
        } completion:^(BOOL finished) 
        {
            [UIView animateWithDuration:0.2/4.5 animations:
             ^{
                view.transform = CGAffineTransformIdentity; 
                [optionsView removeFromSuperview];

            }];
        }];
    }];
    //[optionsView removeFromSuperview];
    
}



/*
 LOGO ANIMATION AT START
 
 */

- (void)fadeOutView:(UIView*)view In:(float)durationInSecond {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:durationInSecond];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    view.alpha = 0.0f;
    
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
    Module *tempModule=[DataHolder.list.modules objectAtIndex:DataHolder.moduleNumber];
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
        index++;
        
        if (index<count ) 
        {
            [overlayView insertSubview:[popUpQueue objectAtIndex:index] aboveSubview:sourceView];
            [self insertView:[popUpQueue objectAtIndex:index] AfterKickingOutViewFromTop:sourceView WithDelay:1.0];
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
    module=[DataHolder.list.modules objectAtIndex:DataHolder.moduleNumber];
    if(!module.isCompleted)
    {
        [self initPopUpQueue];
        [self initAlertOverlay];
        [self.view addSubview:overlayView];
        [self showSequencedPopoverFrom:nil];
    }
    return LIST_COMPLETED_SUCCESSFULLY;
}


-(void)setUpListObject
{
    
    //GET THE LIST.
    DataHolder.list=[TestCase getTestList:@"Surgical"];
    //
    module=[DataHolder.list.modules objectAtIndex:DataHolder.moduleNumber];

    
}
-(void)setModuleValidity:(Module*)mod To:(BOOL)flag
{
    module.moduleCompleted=flag;    
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
    listView.accessoryViewDelegate=self;
    //
    /*
     INITS POP UP HOLDER
     */
    if ( !popUpQueue) {
        popUpQueue = [[NSMutableArray alloc] init];
    }
    //SET THE PAPER LOOK

    [viewEnhancer setThePaperLookForView:self.containerView];
    //OPTIONS VIEW
    optionsView=[self makeOptionsViewWithOptions];
    CGRect screenSize=[[UIScreen mainScreen] bounds];
    optionsView.frame=CGRectMake(screenSize.size.width-167-10,startButton.frame.origin.y+startButton.frame.size.height, 167, 89);
    //CREATING THE STATIC ARRAY OF AVAILABLE LISTS.
    
    @try {
        availableLists=[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:@"Surgical",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",nil]];
        
    }
    @catch (NSException *exception) {
        NSLog(@"Error in view did load method");
    }
    
    //<IF ERROR COME BACK HERE>
    [self setUpListObject];
    //INIT THE subtaskcounter
    subtaskCounter=0;
    //
    [self setModuleValidity:module To:NO];
}

//THIS METHOD MAKES THE ACTUAL LIST VIEW FROM NIB AND SAVES THAT IN LISTVIEW OBJECT.
- (void)createListViewForModule:(int)mod{
    //SET THE MODULE NUMBER TO LOAD.
    DataHolder.moduleNumber=mod;
    //
    ListView *newView = [[ListView alloc] initWithFrame:CGRectMake(containerView.frame.origin.x+340,containerView.frame.origin.y,containerView.frame.size.width,containerView.frame.size.height)];
    [viewEnhancer setThePaperLookForView:newView];
    //SETTING THE WIDTH AND HEIGHT FOR LISTVIEW.
    CGPoint pos=newView.taskTable.frame.origin;
    newView.taskTable.frame=CGRectMake(pos.x,pos.y, 300, 342);

    [self.view insertSubview: newView aboveSubview: containerView];
    
    self.listView = newView;
    //SETTING THE DELEGATE FOR LISTVIEW.
    listView.delegate=self;
    listView.accessoryViewDelegate=self;

    

}

/*
 LOADS THE ACTUAL CHECK LIST ON BOARD WHEN THAT LIST IS CLICKED FROM
 AVAILABLE LIST MENU.
 */

- (void)loadActualListView {

    if(homeButton.enabled==NO)homeButton.enabled=YES;
    if(startButton.hidden==YES)startButton.hidden=NO;
    
    //CREATE THE LIST VIEW WITH PROPER LIST
    
    [self createListViewForModule:0];
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
//THIS METHOD SETS THE ENABILITY OF FORWARD AND BACKWARD BUTTONS
-(void)setEnableButtonsInPopUp:(BOOL)flag
{
        forwardButton.enabled=flag;
        backwardButton.enabled=flag;
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
    [overlayView addSubview:[viewEnhancer makeAlertFromMessage:msg WithButtonTitle:@"Ok,Thanks."]];
    [self.view addSubview:overlayView];
}

-(void)showAlertWithTitle:(NSString*)ttl AndMessage:(NSString*)msg WithAlignment:(UITextAlignment)align
{
    //CREATE AN ALERT WITH THE MESSAGE AND PASS IT ON TO OVERLAYVIEW.
    [self initAlertOverlay];
    [overlayView addSubview:[viewEnhancer makeAlertWithTitle:ttl AndMessage:msg WithButtonTitle:@"Ok." WithAlignment:align]];
    [self.view addSubview:overlayView];

    
}
-(UIView*)makeOptionsViewWithOptions 
{
    UIImageView *iView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"popUp.png"]];
    iView.backgroundColor=[UIColor clearColor];
    iView.userInteractionEnabled=YES;
    //
    CGSize size=iView.frame.size;
    float bottomMargin=50.0f;
    float hMargin=6.0f;
    float buttonHeight=32.0f;
    float buttonWidth=48.0f;
    float hDistance=0.0f;
    //
    playButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [playButton setUserInteractionEnabled:YES];
    forwardButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [forwardButton setUserInteractionEnabled:YES];
    backwardButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backwardButton setUserInteractionEnabled:YES];
    UILabel *separator=[[UILabel alloc] init];
    separator.backgroundColor=[UIColor grayColor];
    //
    [playButton setBackgroundImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [playButton setTag:PLAY_BUTTON_TAG];
    [forwardButton setBackgroundImage:[UIImage imageNamed:@"forward.png"] forState:UIControlStateNormal];
    [forwardButton setTag:FORWARD_BUTTON_TAG];
    [backwardButton setBackgroundImage:[UIImage imageNamed:@"backward.png"] forState:UIControlStateNormal];
    [backwardButton setTag:BACKWARD_BUTTON_TAG];
    //
    hDistance+=hMargin;
    playButton.frame=CGRectMake(hDistance,size.height-bottomMargin,buttonWidth,buttonHeight);
    hDistance+=(buttonWidth+hMargin);
    //
    separator.frame=CGRectMake(hDistance-hMargin/2,size.height-bottomMargin,1, 32);
    //
    backwardButton.frame=CGRectMake(hDistance,size.height-bottomMargin,buttonWidth,buttonHeight);
    hDistance+=(buttonWidth+hMargin);
    forwardButton.frame=CGRectMake(hDistance,size.height-bottomMargin,buttonWidth,buttonHeight);
    //
    [playButton addTarget:self action: @selector(buttonTapped:)forControlEvents:UIControlEventTouchUpInside];
    [forwardButton addTarget:self action: @selector(buttonTapped:)forControlEvents:UIControlEventTouchUpInside];
    [backwardButton addTarget:self action: @selector(buttonTapped:)forControlEvents:UIControlEventTouchUpInside];
    //KEEP FORWARD AND BACKWARD INACTIVE
    backwardButton.enabled=NO;
    forwardButton.enabled=NO;
    
    [iView addSubview:playButton];
    [iView addSubview:separator];
    [iView addSubview:backwardButton];
    [iView addSubview:forwardButton];
    UIView *view=[[UIView alloc] initWithFrame:iView.frame];
    view.backgroundColor=[UIColor clearColor];
    [view addSubview:iView];
    return view;
    
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
        if(!playButton.enabled)playButton.enabled=YES;
        [self setEnableButtonsInPopUp:NO];
        if(module.isCompleted)[self setModuleValidity:module To:NO];
        DataHolder.list=nil;
        if(![optionsView isHidden])
        {
            [optionsView removeFromSuperview];
        }
        
    }
    else if(tag==CREATE_BUTTON_TAG)
    {
        
        //CREATE BUTTON HAS BEEN PRESSED
        NSString *msg=@"This feature is currently under development.\nYou will be notified when an upgrade is available.";
        //[self showAlert:msg];
        [self showAlertWithTitle:@"Unavailable" AndMessage:msg WithAlignment:UITextAlignmentCenter];
    }
    else if(tag==START_BUTTON_TAG)
    {
        startButton.enabled=NO;
        if(![playButton isEnabled])
        {
            if(![self isNextValid])forwardButton.enabled=NO;
            else
                forwardButton.enabled=YES;
            if(![self isBackValid])backwardButton.enabled=NO;
            else
                backwardButton.enabled=YES;
        }
        
        [self popUpAnimForView:optionsView];

        //[self popUpAnimForView:optionsView];
    }
    else if(tag==HELP_BUTTON_TAG)
    {
        
        NSString *msg=@"Simple to use.Just tap a list,when you see the list,tap 'tick' marked button,select the 'play' button there.Once a list is completed you can see your responses by the arrow keys.";
        [self showAlertWithTitle:@"Help" AndMessage:msg WithAlignment:UITextAlignmentCenter];

    }
    else if(tag==PLAY_BUTTON_TAG || tag==FORWARD_BUTTON_TAG || tag==BACKWARD_BUTTON_TAG)
    {
        [self popUpOutAnimForView:optionsView];
        if(![startButton isEnabled] )startButton.enabled=YES;
        if(tag==PLAY_BUTTON_TAG)
        {
            @try {
                [self startInteraction];
            }
            @catch (NSException *exception) {
                NSLog(@"exception: %@",exception);
            }
         
        }
        if(tag==FORWARD_BUTTON_TAG)
        {
            [self nextModule];
        }
        if(tag==BACKWARD_BUTTON_TAG)
        {
            [self backModule];
        }

        //[optionsView removeFromSuperview];
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
    
    [self fadeOutView:logoImage In:4.0]; 
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
