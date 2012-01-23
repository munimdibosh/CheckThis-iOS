//
//  checkThis_nibViewController.h
//  checkThis_nib
//
//  Created by ManGoes Mobile on 20/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ListView.h"


@interface checkThis_nibViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    //OVERLAY VIEW FOR ALERT POP UP.
    UIView *overlayView;
    //
    IBOutlet UIButton *createButton;
    IBOutlet UIButton *homeButton;
    IBOutlet UIImageView *logoImage;
    IBOutlet UIView *containerView;
    IBOutlet UITableView *TableView;
    IBOutlet ListView *listView;
    //
    //Vars
    //
    NSMutableArray *availableLists;
    int array_offset;
    NSMutableArray *addedListButtons;
    int availableListNumber; 
    int animationType;
    
    
}
@property(strong,nonatomic) UIView *overlayView;
@property(strong,nonatomic) IBOutlet UIView *containerView;
@property(strong,nonatomic) IBOutlet UIImageView *logoImage;
@property (strong, nonatomic) IBOutlet UIButton *createButton;
@property(strong,nonatomic)IBOutlet UITableView *TableView;
@property(strong,nonatomic)IBOutlet ListView *listView;


////////////Methods//////////////////
////////////////////////////////////
- (IBAction)showAlert:(id)sender;
- (IBAction)buttonTapped:(id)sender;

-(void)initAvailableLists:(NSArray*)array;
-(void)makeAlertFromMessage:(NSString*)msg;
 @end
