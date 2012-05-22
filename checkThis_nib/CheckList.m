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
-(BOOL)isModuleAvailable:(int)modNum
{
    if(modNum<[modules count])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
-(BOOL)isCompleted
{
    int i=0;
    for(Module *m in modules)
    {
        if(m.isCompleted)i++;
    }
    if(i==[modules count])
        return  YES;
    else
        return NO;
}
-(void)loadModules:(NSArray*)_modules
{
    self.modules=_modules;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeObject:modules forKey:@"module"];
}
- (id)initWithCoder:(NSCoder *)coder {
    self=[super init];
    if(self)
    {

        name = [coder decodeObjectForKey:@"name"];
        modules=[coder decodeObjectForKey:@"module"];
    }
    return self;
}


@end
