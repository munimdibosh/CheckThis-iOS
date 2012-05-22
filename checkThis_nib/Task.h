//
//  Task.h
//  example
//
//  Created by ManGoes Mobile on 28/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject<NSCoding>
{
    NSString* ID;
    NSString *name;
    NSArray *options;
    NSArray *subtasks;
    NSMutableArray *responses;

}
@property (strong,nonatomic)NSString* ID;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSArray *options;
@property(strong,nonatomic) NSArray *subtasks;
@property(strong,nonatomic) NSMutableArray *responses;

-(BOOL)hasSubtasks;



@end
