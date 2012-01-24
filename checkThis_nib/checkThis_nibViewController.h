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
#import "DataHolder.h"
#import "Constants.h"

@interface checkThis_nibViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    //OVERLAY VIEW FOR ALERT POP UP.
    UIView *overlayView;
    //
    IBOutlet UIButton *createButton;
    IBOutlet UIButton *homeButton;
    IBOutlet UIButton *helpButton;
    IBOutlet UIButton *startButton;
    IBOutlet UIImageView *logoImage;
    IBOutlet UIView *containerView;
    IBOutlet UITableView *TableView;
    ListView *listView;
    //
    //Vars
    //
    NSMutableArray *availableLists;
    int animationType;
    
    
}
@property(strong,nonatomic) UIView *overlayView;
@property(strong,nonatomic)IBOutlet UIButton *createButton;
@property(strong,nonatomic)IBOutlet UIButton *homeButton;
@property(strong,nonatomic)IBOutlet UIButton *helpButton;
@property(strong,nonatomic)IBOutlet UIButton *startButton;
@property(strong,nonatomic)IBOutlet UIImageView *logoImage;
@property(strong,nonatomic)IBOutlet UIView *containerView;
@property(strong,nonatomic)IBOutlet UITableView *TableView;
@property(strong,nonatomic)ListView *listView;

////////////Methods//////////////////
////////////////////////////////////
- (IBAction)buttonTapped:(id)sender;
-(void)loadActualListView;
-(void)initAvailableLists:(NSArray*)array;
-(void)makeAlertFromMessage:(NSString*)msg;
 @end
