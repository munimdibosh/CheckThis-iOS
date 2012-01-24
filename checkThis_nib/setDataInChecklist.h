//
//  setDataInChecklist.h
//  new
//
//  Created by Macbook Pro on 23/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


@class SBJsonParser;

@interface setDataInChecklist : NSObject{
    NSData *response;
    SBJsonParser *parser;

    
}
-(NSMutableArray* )getModule:(NSString*)checklist;
-(NSArray* )getTask:(NSString*)module;
-(NSString* )getPreReqsite:(NSString* )module;
-(bool)hasSubtask:(NSString* )module:(NSString*)task;
-(NSMutableArray* )getSubTask:(NSString*)module:(NSString*)task;
-(NSMutableArray* ) getOptions:(NSString *)module:(NSString*)task;
-(NSMutableArray* ) getOptionsForSubtask:(NSString *)module:(NSString*)task:(NSString*)subtask;
-(NSMutableArray* )getChecklists;


@end
