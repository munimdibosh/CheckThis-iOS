//
//  DataHolder.h
//  checkThis_nib
//
//  Created by ManGoes Mobile on 24/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckList.h"
#import "Task.h"
#import "Module.h"
#import "SubTask.h"

@interface DataHolder : NSObject
+(NSString*)listName;
+(int) moduleNumber;
+(void)setModuleNumber:(int)mod;
+(void)setListName:(NSString*)newList;
+(CheckList*)list;
+(void)setList:(CheckList*)lst;
+(void)showResponses;
+(void)showResponses:(CheckList*)lst;

@end
