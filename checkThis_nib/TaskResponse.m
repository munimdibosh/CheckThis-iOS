//
//  TaskResponse.m
//  checkThis_nib
//
//  Created by ManGoes Mobile on 1/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TaskResponse.h"

@implementation TaskResponse
- (id)init
{
    self = [super init];
    if (self) {
        subtaskResponses=[[NSMutableDictionary alloc] init];
        checkedOption=[[NSArray alloc] init];
        // Initialization code here.
    }
    
    return self;
}
-(void)setIndex:(int)n
{
    taskIndex=n;
}
-(int)getIndex
{
    return taskIndex;
}
-(void)addSubtaskResponseOf:(NSString *)name WithSelected:(NSString *)option
{
    [subtaskResponses setValue:option forKey:name];
}
-(NSMutableDictionary*)getSubtaskResponses
{
    return subtaskResponses;
}
-(void)addResponse:(NSArray *)array
{
    checkedOption=array;
}
-(NSArray*)getResponse
{
    return checkedOption;
}

@end
