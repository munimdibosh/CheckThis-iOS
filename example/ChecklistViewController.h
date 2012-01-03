//
//  ChecklistViewController.h
//  example
//
//  Created by ManGoes Mobile on 5/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CheckList.h"
#import "TestCase.h"
@interface ChecklistViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    IBOutlet UILabel *listNameLabel;
    IBOutlet UILabel *moduleNameLabel;
    IBOutlet UIImageView *companyIconImage;
    IBOutlet UIView *listPageView;
    //data provider for the app//test purpose
    CheckList *list;
    Module *module;
    NSArray *tasks;
    NSArray  *subtasks;
    //
    //
    IBOutlet UITableView *TableView;   
}
- (IBAction)alertButtonTapped:(id)sender;
-(void)newLocalScore;
@property(strong,nonatomic) NSArray *tasks;
@property(strong,nonatomic) Module *module;
@property(strong,nonatomic) NSArray *subtasks;
@property(strong,nonatomic) CheckList *list;
@property(strong,nonatomic) UILabel *listNameLabel;
@property(strong,nonatomic) UILabel *moduleNameLabel;
@property(strong,nonatomic) UIImageView *companyIconImage;
@property(strong,nonatomic) UIView *listPageView;
@property(strong,nonatomic) UITableView *TableView;
@end
