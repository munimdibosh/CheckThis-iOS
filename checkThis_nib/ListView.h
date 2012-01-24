
//
//  ListView.h
//  checkThis_nib
//
//  Created by ManGoes Mobile on 22/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckList.h"
#import "Module.h"
#import "TestCase.h"
#import "DataHolder.h"
#import "Constants.h"

@interface ListView : UIView<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
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

    
}
@property(strong,nonatomic)IBOutlet UILabel *listNameLabel;
@property(strong,nonatomic)IBOutlet UILabel *moduleNameLabel;
@property(strong,nonatomic)IBOutlet UITableView *taskTable;
@property(strong,nonatomic)NSString *listName;

- (UITableViewCell*)createTableCellForActualList:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;
/*
 THIS METHOD STARTS THE USER INTERACTION WITH THE LIST.SENDS LIST_COMPLETED_SUCCESSFULLY CODE IF THE USER COMPLETES THE LIST.OR THE ROW WHERE THE USER WAS IN CASE IF HE ABORTS.
 */
-(int)startInteraction;
@end
