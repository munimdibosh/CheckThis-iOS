
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

@interface ListView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UILabel *listNameLabel;
    IBOutlet UILabel *moduleNameLabel;
    IBOutlet UITableView *taskTable;
    //data provider for the app//test purpose
    CheckList *list;
    Module *module;
    NSArray *tasks;
    NSArray  *subtasks;

    
}
@property(strong,nonatomic)IBOutlet UILabel *listNameLabel;
@property(strong,nonatomic)IBOutlet UILabel *moduleNameLabel;
@property(strong,nonatomic)IBOutlet UITableView *taskTable;

- (UITableViewCell*)createTableCellForActualList:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
