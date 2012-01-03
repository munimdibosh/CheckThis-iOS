//
//  Module.m
//  example
//
//  Created by ManGoes Mobile on 28/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Module.h"

@implementation Module
@synthesize ID,name,prerequisites,tasks;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
