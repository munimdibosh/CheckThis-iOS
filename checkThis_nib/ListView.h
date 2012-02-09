
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

@protocol CallImagePickerDelegate
- (void)captureImage:(id)sender;
@end

@interface ListView : UIView<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,ViewEnhancerDelegate>
{
    id<CallImagePickerDelegate> delegate;
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
    NSArray *tasks;
    NSArray  *subtasks;
    //The name of the list it will load
    NSString *listName;
    NSString *selectedOption;
    //Indicates when to update the specified cell.
    BOOL shouldUpdateCell;
}
@property (nonatomic, assign) id <CallImagePickerDelegate> delegate;
@property(strong,nonatomic)IBOutlet UILabel *listNameLabel;
@property(strong,nonatomic)IBOutlet UILabel *moduleNameLabel;
@property(strong,nonatomic)IBOutlet UITableView *taskTable;
@property(strong,nonatomic)NSString *listName;

- (UITableViewCell*)createTableCellForActualList:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
-(void)updateCell:(int)n WithStatus:(NSString*)status WithOption:(NSString*)option;
-(IBAction)detailsViewPressed:(id)sender;

@end
