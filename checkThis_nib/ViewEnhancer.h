//
//  AlertView.h
//  checkThis_nib
//
//  Created by ManGoes Mobile on 29/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Constants.h"
#import "Task.h"
#import "Constants.h"
#import "SubTask.h"
@protocol ViewEnhancerDelegate
-(void)itemTapped:(id)sender;//WHEN THE BUTTON ON ALERT GETS TAPPED
-(void)optionSelected:(NSString*)option ForTask:(int)taskSerial WithSuperView:(UIView*)view;//WHEN A SPECIFIC OPTION/ITEM/ANYTHING GETS SELECTED on A TASK.
@end

@interface ViewEnhancer : UIView
{
    float margin;
    float realWidth;
    float distanceBetweenComponents;
    CGFloat constraintWidthOfText;
    CGRect screenSize;
    

}
@property (nonatomic, assign) id <ViewEnhancerDelegate> delegate;

-(void)setThePaperLookForView:(UIView*)view;
-(UIView*)makeAlertFromMessage:(NSString*) msg WithButtonTitle:(NSString*)ttl;
-(UIView*)makeAlertWithTitle:(NSString*) ttl AndMessage:(NSString*)msg WithButtonTitle:(NSString*)ttl2;

-(UIView*)makeTaskViewWithTitle:(NSString*)title ForTask:(Task*)task WithSerial:(int)serial;
-(UIView*)makeSubTaskViewWithTitle:(NSString*)title OfTask:(NSString*)taskname WithSerial:(int)serial ForSubTask:(SubTask*)subtask;
-(IBAction)optionGotTapped:(id)sender;
-(IBAction)buttonOnAlertGotTapped:(id)sender;
@end
