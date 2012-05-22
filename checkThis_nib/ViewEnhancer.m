//
//  AlertView.m
//  checkThis_nib
//
//  Created by ManGoes Mobile on 29/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewEnhancer.h"

@implementation ViewEnhancer
@synthesize delegate;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)init
{
    self=[super init];
    margin=20.0f;
    distanceBetweenComponents=10.0f;
    realWidth=280.0f;
    screenSize= [[UIScreen mainScreen] bounds];
    constraintWidthOfText=240.0f;
    return self;
}

/*
 SETS THE PAPER LOOK FOR VIEW ON BOARD.
 */

-(void)setThePaperLookForView:(UIView*)view{
    
    //programmatically set image for the paper view    
    UIColor *bgImg=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"paper.png"]];
    view.backgroundColor=bgImg;
    //set shadow of the page
    view.layer.shadowColor=[UIColor blackColor].CGColor;
    view.layer.shadowOpacity=1.0;
    view.layer.shadowRadius=5.0;
    view.layer.shadowOffset=CGSizeMake(0,4);
}

-(UIScrollView*)createViewWithScrollOfFrame:(CGRect)rect WithView:(UIView*)view
{
    UIScrollView *scrollview = [[UIScrollView alloc] initWithFrame:rect];
    CGSize scrollableSize = CGSizeMake(scrollview.frame.size.width, view.frame.size.height);
    [scrollview setContentSize:scrollableSize];

    [scrollview addSubview:view];
    return scrollview;
}

/*
 CREATES A CUSTOM PAPER FEEL ALERT VIEW.
 */
-(UIView*)makeAlertFromMessage:(NSString*) msg WithButtonTitle:(NSString *)ttl{

    float width=screenSize.size.width;
    float height=screenSize.size.height;
    float actualHeight=0.0f;
    float distanceBetweenLabelAndButton=10.0f;
    /*
    DYNAMICALLY RESIZING THE LABEL BASED ON STRING SIZE.
    */
    UIFont *markerFont=[UIFont fontWithName:@"Marker Felt" size:FONT_SIZE_IN_MENU];
    CGSize sizeOfText=[msg sizeWithFont:markerFont constrainedToSize:CGSizeMake(constraintWidthOfText, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    UILabel *messageLabel=[[UILabel alloc] initWithFrame:CGRectMake(20,20,constraintWidthOfText,sizeOfText.height)];
    messageLabel.text=msg;
    messageLabel.backgroundColor=[UIColor clearColor];
    messageLabel.numberOfLines=0;//ENABLES MULTILINING.
    messageLabel.font=markerFont;
    messageLabel.textAlignment=UITextAlignmentCenter;
    //THIS HEIGHT WILL BE USED TO POSITION THE BUTTON.
    float labelHeight=margin+messageLabel.frame.size.height;
    //
    UIButton *okButton=[UIButton buttonWithType:UIButtonTypeCustom];
    okButton.titleLabel.textColor=[[UIColor alloc] initWithRed:(220/255.0) green:(203/255.0) blue:(154/255.0) alpha:1.0];
    okButton.titleLabel.font=[UIFont fontWithName:@"Marker Felt" size:15];
    [okButton setBackgroundImage:[UIImage imageNamed:@"alert_button_bg.png"] forState:UIControlStateNormal];
    [okButton setTitle:ttl forState:UIControlStateNormal];
    [okButton setTag:OVERLAY_BUTTON_TAG];
    [okButton addTarget:self action: @selector(buttonOnAlertGotTapped:)forControlEvents:UIControlEventTouchUpInside];
    UIView *retval;
    okButton.frame=CGRectMake(95,labelHeight+distanceBetweenLabelAndButton,90,30);
    actualHeight=labelHeight+distanceBetweenLabelAndButton+okButton.frame.size.height+margin;
    retval=[[UIView alloc] initWithFrame:CGRectMake(( width/2-realWidth/2),(height/2-actualHeight/2),realWidth,actualHeight)];
    [retval addSubview:messageLabel];
    [retval addSubview:okButton];
    [self setThePaperLookForView:retval];
    return retval;
    

}
/*
 CREATES A CUSTOM PAPER FEEL ALERT VIEW WITH A TITLE.
 */

-(UIView*)makeAlertWithTitle:(NSString*) ttl AndMessage:(NSString*)msg WithButtonTitle:(NSString*)ttl2 WithAlignment:(UITextAlignment)align
{
    float width=screenSize.size.width;
    float height=screenSize.size.height;
    float actualHeight=0.0f;
    float distanceBetweenLabelAndButton=10.0f;
    /*
     DYNAMICALLY RESIZING THE LABEL BASED ON STRING SIZE.
     */
    UIFont *markerFont_20=[UIFont fontWithName:@"Marker Felt" size:FONT_SIZE_IN_MENU];
    UIFont *markerFont_18=[UIFont fontWithName:@"Marker Felt" size:FONT_SIZE_18];
    CGSize sizeOfText=[msg sizeWithFont:markerFont_18 constrainedToSize:CGSizeMake(constraintWidthOfText, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    CGSize sizeOfTitle=[ttl sizeWithFont:markerFont_20 constrainedToSize:CGSizeMake(constraintWidthOfText, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    //TITLE
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(margin,margin,constraintWidthOfText,sizeOfTitle.height)];
    titleLabel.text=ttl;
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.textColor=[UIColor brownColor];
    titleLabel.numberOfLines=0;//ENABLES MULTILINING.
    titleLabel.font=markerFont_20;
    titleLabel.textAlignment=UITextAlignmentCenter;
    //MESSAGE
    UILabel *messageLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0,constraintWidthOfText,sizeOfText.height)];
    messageLabel.text=msg;
    messageLabel.backgroundColor=[UIColor clearColor];
    messageLabel.numberOfLines=0;//ENABLES MULTILINING.
    messageLabel.font=markerFont_18;
    messageLabel.textAlignment=align;
    //THIS HEIGHT WILL BE USED TO POSITION THE BUTTON AN SIZING THE SCROLL VIEW.
    float labelHeight=messageLabel.frame.size.height;
    //
    UIButton *okButton=[UIButton buttonWithType:UIButtonTypeCustom];
    okButton.titleLabel.textColor=[[UIColor alloc] initWithRed:(220/255.0) green:(203/255.0) blue:(154/255.0) alpha:1.0];
    okButton.titleLabel.font=[UIFont fontWithName:@"Marker Felt" size:FONT_SIZE_IN_LIST];
    [okButton setBackgroundImage:[UIImage imageNamed:@"alert_button_bg.png"] forState:UIControlStateNormal];
    [okButton setUserInteractionEnabled:true];
    [okButton setTitle:ttl2 forState:UIControlStateNormal];
    [okButton setTag:OVERLAY_BUTTON_TAG];
    [okButton addTarget:self action: @selector(buttonOnAlertGotTapped:)forControlEvents:UIControlEventTouchUpInside];
    UIView *retval;
    if(labelHeight<=SCROLLER_HEIGHT_IN_ALERT)
    {
        messageLabel.frame=CGRectMake(20,titleLabel.frame.origin.y+titleLabel.frame.size.height+distanceBetweenLabelAndButton,constraintWidthOfText,sizeOfText.height);
        okButton.frame=CGRectMake(95,messageLabel.frame.origin.y+messageLabel.frame.size.height+distanceBetweenLabelAndButton,90,30);
        
        actualHeight=okButton.frame.origin.y+okButton.frame.size.height+margin;
        retval=[[UIView alloc] initWithFrame:CGRectMake(( width/2-realWidth/2),(height/2-actualHeight/2),realWidth,actualHeight)];
        [retval addSubview:titleLabel];
        [retval addSubview:messageLabel];
        [retval addSubview:okButton];
        [self setThePaperLookForView:retval];
    }
    else
    {

        UIScrollView *content=[self createViewWithScrollOfFrame:CGRectMake(20,titleLabel.frame.origin.y+titleLabel.frame.size.height+distanceBetweenLabelAndButton, messageLabel.frame.size.width,SCROLLER_HEIGHT_IN_ALERT) WithView:messageLabel];
        okButton.frame=CGRectMake(95,content.frame.origin.y+content.frame.size.height+distanceBetweenLabelAndButton,90,30);

        actualHeight=okButton.frame.origin.y+okButton.frame.size.height+margin;

        retval=[[UIView alloc] initWithFrame:CGRectMake(( width/2-realWidth/2),(height/2-actualHeight/2),realWidth,actualHeight)];
        [retval addSubview:titleLabel];
        [retval addSubview:content];
        [retval addSubview:okButton];
        [self setThePaperLookForView:retval];
        
        
    }
    return retval;

    
}

-(UIView*)makeTaskViewWithTitle:(NSString *)title ForTask:(Task *)task WithSerial:(int)serial
{
    //THIS VIEW OBJECT IS RETURNED
    UIView *retval=[[UIView alloc]init];
    //
    float height=screenSize.size.height;
    float width=screenSize.size.width;
    float actualHeight=0.0f;//THIS HEIGHT IS UPDATED WITH EACH ADDITION OF A NEW COMPONENT.
    //USED FONTS.
    UIFont *markerFont_20=[UIFont fontWithName:@"Marker Felt" size:FONT_SIZE_IN_MENU];
    UIFont *markerFont_18=[UIFont fontWithName:@"Marker Felt" size:FONT_SIZE_18];
    UIFont *markerFont_15=[UIFont fontWithName:@"Marker Felt" size:FONT_SIZE_IN_LIST];


    //INIT THE TITLE OF THE POP OVER
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0,realWidth,30)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.font=markerFont_20;
    titleLabel.textAlignment=UITextAlignmentCenter;
    titleLabel.text=title;
    actualHeight+=35;
    //THIS CREATES THE SEPARATION LINE BETWEEN TITLE AND TASK NAME
    UILabel *separator=[[UILabel alloc]initWithFrame:CGRectMake(margin,32,constraintWidthOfText,1)];
    separator.backgroundColor=[UIColor blackColor];
    //INIT THE TASK NAME
    CGSize taskNameStringSize=[task.name sizeWithFont:markerFont_18 constrainedToSize:CGSizeMake(constraintWidthOfText,MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    UILabel *taskNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(margin,actualHeight,constraintWidthOfText,taskNameStringSize.height)];
    taskNameLabel.backgroundColor=[UIColor clearColor];
    taskNameLabel.font=markerFont_18;
    taskNameLabel.numberOfLines=0;
    taskNameLabel.text=task.name;
    actualHeight+=(taskNameLabel.frame.size.height+distanceBetweenComponents);
    //
    [retval addSubview:titleLabel];
    [retval addSubview:separator];
    [retval addSubview:taskNameLabel];
    //
    for(NSString *option in task.options)
        {
            UIImageView *checkBox=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkBox_small.png"]];
            checkBox.contentMode=UIViewContentModeCenter;
            float checkBoxWidth=checkBox.frame.size.width;
            float checkBoxHeight=checkBox.frame.size.height;
            checkBox.tag=CHECKBOX_TAG;
            //optionLabel
            CGSize optionSize=[option sizeWithFont:markerFont_15 constrainedToSize:CGSizeMake((constraintWidthOfText- checkBoxWidth), MAXFLOAT)  lineBreakMode:UILineBreakModeWordWrap];
            
            UILabel *optionLabel=[[UILabel alloc]initWithFrame:CGRectMake(checkBoxWidth,0,constraintWidthOfText-checkBoxWidth,optionSize.height+10)];
            optionLabel.text=option;
            optionLabel.backgroundColor=[UIColor clearColor];
            optionLabel.numberOfLines=0;//ENABLES MULTILINING.
            optionLabel.font=markerFont_15;
            optionLabel.tag=OPTION_LABEL_TAG;
            //FIX THE HEIGHT FOR CHECKBOX
            checkBox.frame=CGRectMake(0, 0, checkBoxWidth,optionSize.height+10);
            //WRAP THE OPTION LABEL AND CHECK BOX INSIDE BUTTON TO GET USER TAPS

            UIButton *labelContainer=[UIButton buttonWithType:UIButtonTypeCustom];
            [labelContainer addSubview:optionLabel];
            [labelContainer addSubview:checkBox];
            [labelContainer setFrame:CGRectMake(margin,actualHeight,constraintWidthOfText,optionLabel.frame.size.height)];
            [labelContainer  addTarget:self action: @selector(optionGotTapped:)forControlEvents:UIControlEventTouchUpInside];
            //LABEL CONTAINER WILL TELL WHICH TASK HAS BEEN COMPLETED.
            labelContainer.tag=serial;
            //
            actualHeight+=(distanceBetweenComponents+optionLabel.frame.size.height);
            //
            [retval addSubview:labelContainer];
            
    }
    [retval setFrame:CGRectMake( (width/2-realWidth/2),(height/2-actualHeight/2),realWidth,actualHeight)];
    [self setThePaperLookForView:retval];
    //SAVE TO IDENTIFY WHICH VIEW IS THIS
    retval.tag=TASK_VIEW;
    //

    return retval;
}

-(UIView*)makeSubTaskViewWithTitle:(NSString*)title OfTask:(NSString *)taskname WithSerial:(int)serial ForSubTask:(SubTask *)subtask
{
    //THIS VIEW OBJECT IS RETURNED
    UIView *retval=[[UIView alloc]init];
    //
    float height=screenSize.size.height;
    float width=screenSize.size.width;
    float actualHeight=0.0f;//THIS HEIGHT IS UPDATED WITH EACH ADDITION OF A NEW COMPONENT.
    //USED FONTS.
    UIFont *markerFont_20=[UIFont fontWithName:@"Marker Felt" size:FONT_SIZE_IN_MENU];
    UIFont *markerFont_18=[UIFont fontWithName:@"Marker Felt" size:FONT_SIZE_18];
    UIFont *markerFont_16=[UIFont fontWithName:@"Marker Felt" size:FONT_SIZE_16];
    UIFont *markerFont_15=[UIFont fontWithName:@"Marker Felt" size:FONT_SIZE_IN_LIST];
    
    
    //INIT THE TITLE OF THE POP OVER
    UILabel *titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,0,realWidth,30)];
    titleLabel.backgroundColor=[UIColor clearColor];
    titleLabel.font=markerFont_20;
    titleLabel.textAlignment=UITextAlignmentCenter;
    titleLabel.text=title;
    //
    actualHeight+=35;
    //THIS CREATES THE SEPARATION LINE BETWEEN TITLE AND TASK NAME
    UILabel *separator=[[UILabel alloc]initWithFrame:CGRectMake(margin,32,constraintWidthOfText,1)];
    separator.backgroundColor=[UIColor blackColor];
    //INIT THE TASK NAME
    CGSize taskNameStringSize=[taskname sizeWithFont:markerFont_18 constrainedToSize:CGSizeMake(constraintWidthOfText,MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    UILabel *taskNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(margin,actualHeight,constraintWidthOfText,taskNameStringSize.height)];
    taskNameLabel.backgroundColor=[UIColor clearColor];
    taskNameLabel.font=markerFont_18;
    taskNameLabel.numberOfLines=0;
    taskNameLabel.text=taskname;
    //
    actualHeight+=(taskNameLabel.frame.size.height+distanceBetweenComponents);
    //INIT THE SUBTASK TREE VIEW
    UIImageView *tree=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tree.png"]];
    tree.contentMode=UIViewContentModeCenter;
    float treeImageWidth=tree.frame.size.width;
    float treeImageHeight=tree.frame.size.height;
    tree.frame=CGRectMake(0, 0, treeImageWidth, treeImageHeight);
    //SUBTASK LABEL
    CGSize subTaskNameStringSize=[subtask.name sizeWithFont:markerFont_16 constrainedToSize:CGSizeMake(constraintWidthOfText-treeImageWidth,MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    UILabel *subTaskNameLabel=[[UILabel alloc] initWithFrame:CGRectMake(treeImageWidth,0,(constraintWidthOfText-treeImageWidth),subTaskNameStringSize.height)];
    subTaskNameLabel.backgroundColor=[UIColor clearColor];
    subTaskNameLabel.font=markerFont_16;
    subTaskNameLabel.numberOfLines=0;
    subTaskNameLabel.text=subtask.name;
    //SUBTASK NAME CONTAINER,THAT WRAPS THE TREE LOOK WITH NAME LABEL.
    UILabel *container=[[UILabel alloc] initWithFrame:CGRectMake(margin,actualHeight,constraintWidthOfText,subTaskNameLabel.frame.size.height)];
    container.backgroundColor=[UIColor clearColor];
    [container addSubview:tree];
    [container addSubview:subTaskNameLabel];
    //
    actualHeight+=(container.frame.size.height+distanceBetweenComponents);

    //
    [retval addSubview:titleLabel];
    [retval addSubview:separator];
    [retval addSubview:taskNameLabel];
    [retval addSubview:container];
    //
    for(NSString *option in subtask.options)
        {
            UIImageView *checkBox=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkBox_small.png"]];
            checkBox.contentMode=UIViewContentModeCenter;
            float checkBoxWidth=checkBox.frame.size.width;
            checkBox.tag=CHECKBOX_TAG;
            //optionLabel
            CGSize optionSize=[option sizeWithFont:markerFont_15 constrainedToSize:CGSizeMake((constraintWidthOfText- checkBoxWidth), MAXFLOAT)  lineBreakMode:UILineBreakModeWordWrap];
            
            UILabel *optionLabel=[[UILabel alloc]initWithFrame:CGRectMake(checkBoxWidth,0,constraintWidthOfText-checkBoxWidth,optionSize.height+10)];
            optionLabel.text=option;
            optionLabel.backgroundColor=[UIColor clearColor];
            optionLabel.numberOfLines=0;//ENABLES MULTILINING.
            optionLabel.font=markerFont_15;
            optionLabel.tag=OPTION_LABEL_TAG;
            //SET THE checkBox Height
            checkBox.frame=CGRectMake(0, 0, checkBoxWidth, optionSize.height+10);

            //WRAP THE OPTION LABEL AND CHECK BOX INSIDE BUTTON TO GET USER TAPS
            
            UIButton *labelContainer=[UIButton buttonWithType:UIButtonTypeCustom];
            [labelContainer addSubview:optionLabel];
            [labelContainer addSubview:checkBox];
            [labelContainer setFrame:CGRectMake(margin,actualHeight,constraintWidthOfText,optionLabel.frame.size.height)];
            [labelContainer  addTarget:self action: @selector(optionGotTapped:)forControlEvents:UIControlEventTouchUpInside];
            //LABEL CONTAINER WILL TELL WHICH TASK HAS BEEN COMPLETED.
            labelContainer.tag=serial;
            //

            //
            actualHeight+=(distanceBetweenComponents+optionLabel.frame.size.height);
            //
            [retval addSubview:labelContainer];
            
    }    
    [retval setFrame:CGRectMake( (width/2-realWidth/2),(height/2-actualHeight/2),realWidth,actualHeight)];
    [self setThePaperLookForView:retval];
    //SAVE TO IDENTIFY WHICH VIEW IS THIS
    retval.tag=SUBTASK_VIEW;
    //
    return retval;

}



/*
 AUTOMATIC CALL BACK WHEN AN ITEM/OPTION ON THE VIEW GET PRESSED.SENT TO DELEGATE IMMIDIATELY.
 */
-(IBAction)optionGotTapped:(id)sender
{
    UIView *actionSender=(UIView*)sender;
    UIView *superView=[actionSender superview];
    for(UIView *view in actionSender.subviews)
    {
        if(view.tag==CHECKBOX_TAG)
        {
            UIImageView *iv=(UIImageView*)view;
            [iv setImage:[UIImage imageNamed:@"checkBox_checked_small.png"]];
        }
        else if(view.tag==OPTION_LABEL_TAG)
        {
            UILabel *label=(UILabel*)view;
            [self.delegate optionSelected:label.text ForTask:actionSender.tag WithSuperView:superView];
        }
    }

}
-(IBAction)buttonOnAlertGotTapped:(id)sender
{
    UIButton *actionSender=(UIButton*)sender;
    //IF THIS TAG IS FOUND THAT MEANS ITS AN ALERT ONLY!
    if(actionSender.tag==OVERLAY_BUTTON_TAG)
    {
        [self.delegate itemTapped:actionSender];
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

@end
