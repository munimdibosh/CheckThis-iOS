//
//  checkThis_nibViewController.h
//  checkThis_nib
//
//  Created by ManGoes Mobile on 20/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIStringDrawing.h>
#import <QuartzCore/QuartzCore.h>
#import "ListView.h"
#import "ViewEnhancer.h"
#import "DataHolder.h"
#import "Constants.h"
#import "TestCase.h"

@interface checkThis_nibViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate, CallImagePickerDelegate,ViewEnhancerDelegate>
{
    //THIS CLASS IS RESPONSIBLE FOR DIFFERENT TYPES OF UI DESIGNS.
    ViewEnhancer *viewEnhancer;
    //OVERLAY VIEW FOR ALERT POP UP.
    UIView *overlayView;
    //POP OVERS THAT GETS SHIFTED
    UIView *currentView;
    UIView *prevView;
    //IMAGE PICKER CONTROLLER THAT IS USED TO SELECT/PICK PHOTO.
    UIImagePickerController *imgPicker;
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
    //data provider for the app//test purpose
    CheckList *list;
    Module *module;
    //THE POP UP QUEUE
    NSMutableArray *popUpQueue;
    //USED TO DETECT WHETHER ALL SUBTASKS GOT COMPLETED.
    int subtaskCounter;
    //MODULE COMPLETED BOOLEAN
    BOOL moduleCompleted;
    
}
@property(strong,nonatomic)ViewEnhancer  *viewEnhancer;
@property(strong,nonatomic)UIImagePickerController *imgPicker;
@property(strong,nonatomic) UIView *overlayView;
@property(strong,nonatomic)IBOutlet UIButton *createButton;
@property(strong,nonatomic)IBOutlet UIButton *homeButton;
@property(strong,nonatomic)IBOutlet UIButton *helpButton;
@property(strong,nonatomic)IBOutlet UIButton *startButton;
@property(strong,nonatomic)IBOutlet UIImageView *logoImage;
@property(strong,nonatomic)IBOutlet UIView *containerView;
@property(strong,nonatomic)IBOutlet UITableView *TableView;
@property(strong,nonatomic)ListView *listView;
@property(strong,nonatomic)NSMutableArray *popUpQueue;


////////////Methods//////////////////
////////////////////////////////////
-(void)showAlert:(NSString*)msg;
-(void)dismissAlert;
-(void)showImagePicker;
-(void)initAlertOverlay;
- (IBAction)buttonTapped:(id)sender;
-(void)loadActualListView;
-(void)initAvailableLists:(NSArray*)array;
-(void)makeAlertFromMessage:(NSString*)msg;
-(BOOL)showSequencedPopoverFrom:(UIView *)sourceView;
-(void)insertView:(UIView*)newView AfterKickingOutViewFromTop:(UIView*)oldView WithDelay:(float)durationInSecond;
-(void)insertView:(UIView*)newView AfterPullingOutView:(UIView*)oldView WithDelay:(float)durationInSecond;
-(void)insertView:(UIView*)newView AfterKickingOutView:(UIView*)oldView WithDelay:(float)durationInSecond;
 @end
