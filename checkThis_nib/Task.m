//
//  Task.m
//  example
//
//  Created by ManGoes Mobile on 28/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Task.h"

@implementation Task
@synthesize ID,name,options,subtasks,responses;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
-(BOOL)hasSubtasks
{
    if([subtasks count]==0)
        return false;
    return true;
}

@end
