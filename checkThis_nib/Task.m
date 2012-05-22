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
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:subtasks forKey:@"subtask"];
    [aCoder encodeObject:responses forKey:@"responses"];
}
- (id)initWithCoder:(NSCoder *)coder {
    self=[super init];
    if(self)
    {
        name = [coder decodeObjectForKey:@"name"];
        subtasks=[coder decodeObjectForKey:@"subtask"];
        responses = [coder decodeObjectForKey:@"responses"];
    }
    return self;

}


@end
