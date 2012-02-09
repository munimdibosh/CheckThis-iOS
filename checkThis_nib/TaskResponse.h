//
//  TaskResponse.h
//  checkThis_nib
//
//  Created by ManGoes Mobile on 1/2/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskResponse : NSObject
{
    int taskIndex;
    NSMutableDictionary *subtaskResponses;
    NSArray *checkedOption;
}
-(void)setIndex:(int)n;
-(int)getIndex;
-(void)addSubtaskResponseOf:(NSString*)name WithSelected:(NSString*)option;
-(NSMutableDictionary*)getSubtaskResponses;
-(void)addResponse:(NSArray*)array;
-(NSArray*)getResponse;
@end