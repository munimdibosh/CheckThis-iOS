//
//  exampleViewController.h
//  example
//
//  Created by ManGoes Mobile on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#import "ChecklistViewController.h"

@interface exampleViewController : UIViewController<UIScrollViewDelegate>
{
    IBOutlet ChecklistViewController *checkListView;
    //
    //View Items
    //
    //UIButton *createButton;
    IBOutlet UIImageView *logoImage;
    IBOutlet UIScrollView *gridView;
    IBOutlet UIPageControl *pageControl;
    IBOutlet UIView *containerView;
    //
    //Vars
    //
    NSMutableArray *availableLists;
    int array_offset;
    NSMutableArray *addedListButtons;
    int availableListNumber;
    BOOL pageControlBeingUsed;
    
}
@property (strong,nonatomic)ChecklistViewController *checkListView;
@property(strong,nonatomic) IBOutlet UIView *containerView;
@property(strong,nonatomic) IBOutlet UIImageView *logoImage;
@property (strong, nonatomic) IBOutlet UIButton *createButton;
@property(strong,nonatomic) IBOutlet UIScrollView *gridView;
@property(strong,nonatomic)IBOutlet UIPageControl *pageControl;
////////////Action Methods////////////
/////////////////////////////////////
-(IBAction)loadListView:(id)sender;
-(IBAction)buttonImageToggle:(id)sender;
-(IBAction)changePage;
////////////Methods//////////////////
////////////////////////////////////
-(void)initAvailableLists:(NSArray*)array;
-(UIView *)createListGridWithRows:(int)rows AndCollumns:(int)cols OnView:(UIView*)view;
-(void)createListPaneWithPages:(int)pages;


@end
