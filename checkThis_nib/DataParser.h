//
//  setDataInChecklist.h
//  new
//
//  Created by Macbook Pro on 23/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import "Constants.h"

@class SBJsonParser;

@interface DataParser : NSObject{
    NSData *response;
    SBJsonParser *parser;

    
}
-(NSMutableArray* )getModulesOf:(NSString*)checklist;
-(NSArray* )getTasksOf:(NSString*)module;
-(NSString* )getPreReqsOf:(NSString* )module;
-(bool)hasSubtask:(NSString* )module:(NSString*)task;
-(NSMutableArray* )getSubTask:(NSString*)module:(NSString*)task;
-(NSMutableArray* ) getOptions:(NSString *)module:(NSString*)task;
-(NSMutableArray* ) getOptionsForSubtask:(NSString *)module:(NSString*)task:(NSString*)subtask;
-(NSMutableArray* )getChecklists:(NSData*)webResponse;


@end
