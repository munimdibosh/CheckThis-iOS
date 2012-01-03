//
//  CheckList.m
//  example
//
//  Created by ManGoes Mobile on 28/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CheckList.h"

@implementation CheckList
@synthesize ID,name,modules;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)loadModules:(NSArray*)_modules
{
    self.modules=_modules;
}

@end
