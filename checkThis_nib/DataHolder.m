//
//  DataHolder.m
//  checkThis_nib
//
//  Created by ManGoes Mobile on 24/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DataHolder.h"
static NSString* listName;
static int moduleNumber;
static CheckList *list;

@implementation DataHolder
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(NSString*)listName
{
    return listName;
}
+(void)setListName:(NSString *)newList
{
    if (listName!= newList) {
        listName = [newList copy];
    }
 
}
+(int) moduleNumber{
    return moduleNumber;
}
+(void)setModuleNumber:(int)mod
{
    if(moduleNumber!=mod)
    {
        moduleNumber=mod;
    }
}
+(CheckList*)list{
    return list;
}
+(void)setList:(CheckList*)lst{
    if(list!=lst)
    {
        list=lst;
    }
}

/*
 SHOW RESPONSES IN CONSOLE
 */
+(void)showResponses
{
    CheckList *lst=DataHolder.list;
    Module *m=[lst.modules objectAtIndex:DataHolder.moduleNumber];
    NSLog(@"----------------------RESPONSE PRINT---------------");
    NSLog(@"%@",m.name);
    for(Task *t in m.tasks)
    {
        NSLog(@"%@",t.name);
        if([t hasSubtasks])
        {
            for(SubTask *s in t.subtasks)
            {
                NSLog(@"%@-%@",s.name,[s.responses objectAtIndex:0]);
            }
        }
        else
        {
            NSLog(@"%@",[t.responses objectAtIndex:0]);
        }
    }
}

+(void)showResponses:(CheckList*)lst
{
    Module *m=[lst.modules objectAtIndex:DataHolder.moduleNumber];
    NSLog(@"----------------------RESPONSE PRINT---------------");
    NSLog(@"%@",m.name);
    for(Task *t in m.tasks)
    {
        NSLog(@"%@",t.name);
        if([t hasSubtasks])
        {
            for(SubTask *s in t.subtasks)
            {
                NSLog(@"%@-%@",s.name,[s.responses objectAtIndex:0]);
            }
        }
        else
        {
            NSLog(@"%@",[t.responses objectAtIndex:0]);
        }
    }

    
}





@end
