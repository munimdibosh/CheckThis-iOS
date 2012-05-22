//
//  SubTask.m
//  example
//
//  Created by ManGoes Mobile on 28/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SubTask.h"

@implementation SubTask
@synthesize ID,name,options,responses;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:responses forKey:@"responses"];
}
- (id)initWithCoder:(NSCoder *)coder {
    self=[super init];
    if(self)
    {
        name = [coder decodeObjectForKey:@"name"];
        responses = [coder decodeObjectForKey:@"responses"];
    }
    return self;
}


@end
