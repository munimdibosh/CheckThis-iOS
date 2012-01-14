//
//  exampleViewController.m
//  example
//
//  Created by ManGoes Mobile on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "exampleViewController.h"

@implementation exampleViewController
@synthesize checkListView;
@synthesize createButton;
@synthesize gridView;
@synthesize pageControl;
@synthesize logoImage;
@synthesize containerView;

-(UIView *)createListGridWithRows:(int)rows AndCollumns:(int)cols OnView:(UIView *)view
{
    float gridWidth=view.bounds.size.width;
    float gridHeight=view.bounds.size.height;
    float buttonWidth=60.0;
    float buttonHeight=56.0;
    float horizontalGap=(gridWidth-(buttonWidth*cols))/(cols+1);
    float verticalGap=(gridHeight-(buttonHeight* rows))/(rows+1);
    float offsetX;
    float offsetY=view.bounds.size.height-gridHeight;
    //the gap between label & button & height of label
    float gap=2.0;
    float labelHeight=28.0;
    
    int count=0;
    do {
        offsetX=horizontalGap+((count%cols)*(buttonWidth+horizontalGap));
        offsetY+=verticalGap+((count/cols)*(buttonHeight+verticalGap));
        //common attribs of the dynamic buttons
        UIButton *aButton=[[UIButton alloc]initWithFrame:CGRectMake(offsetX,offsetY, buttonWidth, buttonHeight)];
        aButton.tag=count;
        //
        //define the label under the button
        UILabel *aLabel=[[UILabel alloc]initWithFrame:CGRectMake(offsetX,offsetY+buttonHeight+gap, buttonWidth, labelHeight)];
        aLabel.backgroundColor =[UIColor clearColor];
        aLabel.textColor=[[UIColor alloc] initWithRed:(160/255.f) green:(108/255.f) blue:(55/255.f) alpha:1.0];//dividing by 255 converts it as 0.0 to 1.0
        aLabel.font=[UIFont systemFontOfSize:12.0];
        aLabel.textAlignment=UITextAlignmentCenter;
        aLabel.adjustsFontSizeToFitWidth=YES;
        
        //setting the image according to availability of the lists.empty image for empty list
        if(![[availableLists objectAtIndex:array_offset]isEqualToString:@"Unavailable"])
        {
            aButton.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"list_icon.png"]];
           //[aButton addTarget:self action:@selector(buttonImageToggle:) forControlEvents:UIControlEventTouchUpInside];//define the state change image function
            [aButton addTarget:self action:@selector(loadListView:) forControlEvents:UIControlEventTouchUpInside];
            aLabel.text= [availableLists objectAtIndex:array_offset];
        }
        else
        {
            aButton.backgroundColor=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"list_icon_empty.png"]];   
            aLabel.text=@"Unavailable";
        }
        
        [view addSubview:aButton];
        [view addSubview:aLabel];
        [addedListButtons addObject:aButton];
        offsetX=buttonWidth+horizontalGap;
        offsetY=view.bounds.size.height-gridHeight;
        array_offset++;
        count++;
    } while (count<rows*cols);
    return view;
}


-(void)createListPaneWithPages:(int)pages
{
    for (int i = 0; i < pages; i++) {
        CGRect frame;
        frame.origin.x = gridView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = gridView.frame.size;
        
        UIView *subview = [[UIView alloc] initWithFrame:frame];
        subview.backgroundColor = [UIColor clearColor];
        [gridView addSubview:[self createListGridWithRows:2 AndCollumns:3 OnView:subview]];
    }
    gridView.contentSize = CGSizeMake(gridView.frame.size.width * pages,gridView.frame.size.height);
}
//this method loads the actual check list
-(IBAction)loadListView:(id)sender
{
    [self performSegueWithIdentifier:@"checkListView" sender:sender];
}
//this method toggles the image on selected/normal button
-(IBAction)buttonImageToggle:(id)sender
{
    if([sender isSelected])
    {
        [sender setImage:[UIImage imageNamed:@"list_icon.png"] forState:UIControlStateSelected];
        [sender setSelected:NO];
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"list_icon_tapped.png"] forState:UIControlStateSelected];
        [sender setSelected:YES];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)fadeOutLogo:(float)durationInSecond {
    //programmatically set image for the paper view    
     UIColor *bgImg=[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"paper.png"]];
     self.containerView.backgroundColor=bgImg;
    //
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:durationInSecond];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    
    logoImage.alpha = 0.0f;
    
    [UIView commitAnimations];
}

- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context 
{
    pageControl.hidden=NO;
	[self createListPaneWithPages:3];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //at first the page control should be invisible
    pageControl.hidden=YES;
    //set shadow of the page
    containerView.layer.shadowColor=[UIColor blackColor].CGColor;
    containerView.layer.shadowOpacity=1.0;
    containerView.layer.shadowRadius=5.0;
    containerView.layer.shadowOffset=CGSizeMake(0,4); 
    //fades the logo out
    [self fadeOutLogo:5.0];
    //
    array_offset=0;
    //unit test
    //NSLog(@"HERE");
    @try {
                availableLists=[[NSMutableArray alloc] initWithArray:[NSArray arrayWithObjects:@"Surgical",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",@"Unavailable",nil]];
                availableListNumber=1;
    }
    @catch (NSException *exception) {
        NSLog(@"Error in view did load method");
    }
    
    gridView.delegate=self;
    //
    pageControlBeingUsed=NO;
    
}


//method specific to scrollview,when you scroll the pane the page changes too though you didnt use pagecontrol

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (pageControlBeingUsed) {
        return;
    }
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = gridView.frame.size.width;
    int page = floor((gridView.contentOffset.x - pageWidth/2) / pageWidth) + 1;
    
    pageControl.currentPage=page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView 
{ 
    pageControlBeingUsed = NO;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView 
{ 
    pageControlBeingUsed = NO;
}


//method that actually changes the page

- (IBAction)changePage {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = gridView.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = gridView.frame.size;
    pageControlBeingUsed = YES;
    [gridView scrollRectToVisible:frame animated:YES];
}




- (void)viewDidUnload
{
    [self setCreateButton:nil];    
    gridView = nil;
    pageControl = nil;
    logoImage = nil;
    containerView = nil;
    checkListView = nil;
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
