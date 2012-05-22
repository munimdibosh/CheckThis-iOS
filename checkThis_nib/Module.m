//
//  Module.m
//  example
//
//  Created by ManGoes Mobile on 28/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Module.h"

@implementation Module
@synthesize ID,name,prerequisites,tasks,moduleCompleted;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(BOOL)isCompleted
{
    return moduleCompleted;
}
-(void)setCompleted:(BOOL)flag
{
    moduleCompleted=flag;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:tasks forKey:@"task"];
}
- (id)initWithCoder:(NSCoder *)coder {
    self=[super init];
    if(self)
    {

        name = [coder decodeObjectForKey:@"name"];
        tasks=[coder decodeObjectForKey:@"task"];
    }
    return self;
}



@end
