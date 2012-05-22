
//
//  ListView.h
//  checkThis_nib
//
//  Created by ManGoes Mobile on 22/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CheckList.h"
#import "Module.h"
#import "TestCase.h"
#import "DataHolder.h"
#import "Constants.h"
#import "proAlertView.h"
#import "ViewEnhancer.h"
#import "CustomAccessoryButton.h"

@protocol CallImagePickerDelegate
- (void)captureImage:(id)sender;
@end
@protocol ListViewDelegate
-(void)showAccessoryViewForSubtasksOfTask:(int)serial;
@end

@interface ListView : UIView<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,ViewEnhancerDelegate>
{
    id<CallImagePickerDelegate> delegate;
    id<ListViewDelegate>accessoryViewDelegate;
    //
    UIView *overlayView;
    UIView *prevView;
    UIView* currentView;
    
    //
    IBOutlet UILabel *listNameLabel;
    IBOutlet UILabel *moduleNameLabel;
    IBOutlet UITableView *taskTable;
    //data provider for the app//test purpose
    CheckList *list;
    Module *module;
    //The name of the list it will load
    NSString *listName;
    //Indicates when to update the specified cell.
    BOOL shouldUpdateCell;
}
@property (nonatomic, assign) id <CallImagePickerDelegate> delegate;
@property (nonatomic, assign) id <ListViewDelegate> accessoryViewDelegate;

@property(strong,nonatomic)IBOutlet UILabel *listNameLabel;
@property(strong,nonatomic)IBOutlet UILabel *moduleNameLabel;
@property(strong,nonatomic)IBOutlet UITableView *taskTable;
@property(strong,nonatomic)NSString *listName;

- (UITableViewCell*)createTableCellForActualList:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
-(void)updateCell:(int)n WithStatus:(NSString*)status;
-(void)updateCellsWithStatus:(NSString*)status;
-(IBAction)detailsViewPressed:(id)sender;
-(NSMutableArray*)indexPaths;
-(NSMutableArray*)subtaskResponsesForTask:(Task*)task;


@end
