//
//  Constants.h
//  checkThis_nib
//
//  Created by ManGoes Mobile on 24/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
/*OVERLAY BUTTON IS THE BUTTON AT CUSTOM ALERT*/
#define OVERLAY_BUTTON_TAG 5540
#define HOME_BUTTON_TAG 5550
#define CREATE_BUTTON_TAG 5560
#define START_BUTTON_TAG 5570
#define PLAY_BUTTON_TAG 5572
#define FORWARD_BUTTON_TAG 5574
#define BACKWARD_BUTTON_TAG 5576
#define HELP_BUTTON_TAG 5580
#define CHECKBOX_TAG 6660
#define OPTION_LABEL_TAG 6670
#define LIST_COMPLETED_SUCCESSFULLY 1
#define LIST_INCOMPLETED 0
#define SERVER_URL  @"http://localhost:8888/Checkthis/index.php/mainControler/getChecklists"
#define CLOSE_ALERT_CONFIRM @"CONFIRM_CLOSE_WITH_THANKS"
#define FONT_SIZE_IN_LIST 15.0f
#define FONT_SIZE_IN_MENU 20.0f
#define FONT_SIZE_18 18.0f
#define FONT_SIZE_16 16.0f
#define CELL_CONTENT_WIDTH 300.0f
#define CELL_CONTENT_MARGIN 20.0f
#define CELL_IMAGE_WIDTH 32.0f
#define SCROLLER_HEIGHT_IN_ALERT 300
#define MAX_ALERT_HEIGHT 400
#define TASK_COMPLETED  @"task_complete"
#define SUBTASK_VIEW 4567
#define TASK_VIEW 4577
//KEY FOR NSCODINGS
#define SUBTASK_IDENTIFIER @"subtask"
#define SUBTASK_NAME_KEY @"subtask_name"
#define SUBTASK_OPTIONS_KEY @"subtask_options"
#define SUBTASK_RESPONSE_KEY @"subtask_response"
/**********/
#define TASK_IDENTIFIER @"task"
#define TASK_NAME_KEY @"task_name"
#define TASK_OPTIONS_KEY @"task_options"
#define TASK_RESPONSE_KEY @"task_response"
#define TASK_SUBTASKS_KEY @"task_subtask"
/*****************/
#define MODULE_IDENTIFIER @"module"
#define MODULE_PRE_KEY @"prereqs"
#define MODULE_NAME_KEY @"module_name"
#define MODULE_TASKS_KEY @"module_tasks"
/****************/
#define CHECKLIST_IDENTIFIER @"checklist"
#define CHECKLIST_NAME_KEY @"checklist_name"
#define CHECKLIST_MODULES_KEY @"checklist_module"


/*
 THE FOLLOWING KEYS ARE USED TO SAVE AND RETRIEVE DATA USING NSCoding
 */
#define KEY_ID @"id"
#define KEY_NAME @"name"
#define KEY_OPTIONS @"options"
#define KEY_RESPONSES @"response" 
#define KEY_MODULES @"module"
#define KEY_PREREQS @"pre_reqs"
#define KEY_TASKS @"tasks"
#define KEY_SUBTASKS @"subtasks"

@interface Constants : NSObject

@end
