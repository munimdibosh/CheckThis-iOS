//
//  setDataInChecklist.m
//  new
//
//  Created by Macbook Pro on 23/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "setDataInChecklist.h"
#import "SBJson.h"

@implementation setDataInChecklist

 
-(NSMutableArray *)getChecklists{ 
    SBJsonParser *p=[[SBJsonParser alloc] init];
    
    NSURL *cheklistURL= [NSURL URLWithString:@"http://192.168.1.112:8888/Checkthis/index.php/mainControler/getChecklists"];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setURL:cheklistURL];
    NSData *chicklistData =[NSURLConnection sendSynchronousRequest:req returningResponse:nil error:nil];
    NSMutableArray *checklists = [p objectWithData:chicklistData];
    NSMutableArray * checklistsArray = [[NSMutableArray alloc] init];
    for(id checklist in checklists){
        NSLog(@"Checklist: %@",checklist);
        [checklistsArray addObject:checklist];
        
    }
    return checklistsArray;
}

-(NSMutableArray *)getModule:(NSString *)checklist{
    parser=[[SBJsonParser alloc] init];
    //ASIHTTPRequest *r;
    NSURL *url= [NSURL URLWithString:@"http://192.168.1.112:8888/Checkthis/index.php/mainControler/getfullchecklist"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    //NSDictionary *tasks=[parser objectWithData:response];
    NSMutableArray *modules = [parser objectWithData:response];
    NSMutableArray *moduleArray =[[NSMutableArray alloc] init];
    for (NSString *module in modules){
      
        [moduleArray addObject:module];
        
    }
    return moduleArray;
    
}

-(NSString *)getPreReqsite:(NSString *)module{
    NSDictionary *data=[parser objectWithData:response];
    
    NSDictionary *dataforTask = [data objectForKey:module];
    NSArray *pre=[dataforTask objectForKey:@"prerequisite"];
    NSString *preReq= [[NSString alloc] init];
    for(id s in pre){
        preReq=s;
    }
    return preReq;
}

- (NSMutableArray *)getTask:(NSString*)module{
    NSDictionary *data=[parser objectWithData:response];
    
    NSDictionary *dataforTask = [data objectForKey:module];
    NSArray *tasks= [dataforTask objectForKey:@"tasks"];
   
    NSMutableArray * taskArray=[[NSMutableArray alloc] init];
    for(id task in tasks){
        [taskArray addObject:task];
    }
    return taskArray;
    
    
}

-(bool)hasSubtask:(NSString *)module :(NSString *)task{
    NSDictionary *data=[parser objectWithData:response];
    
    NSDictionary *dataforTask = [data objectForKey:module];
    
    NSDictionary *dataforOptions = [dataforTask objectForKey:@"tasks"];
    
    NSDictionary *options = [dataforOptions objectForKey:task];
    NSString* type =[options objectForKey:@"option_type"];
    if(type!=NULL){
        return FALSE;
    }else{
        return TRUE;
    }
    
}

-(NSMutableArray *)getOptions:(NSString *)module :(NSString *)task{
    NSDictionary *data=[parser objectWithData:response];
    
    NSDictionary *dataforTask = [data objectForKey:module];
    
    NSDictionary *dataforOptions = [dataforTask objectForKey:@"tasks"];
    
    NSDictionary *options = [dataforOptions objectForKey:task];
  
    NSMutableArray *optionArray =[[NSMutableArray alloc] init];
    
        
        for(NSInteger i=0;i<[options count]-1;i++){
            NSString *index = [NSString stringWithFormat:@"%d", i];
           
            [optionArray addObject:[options objectForKey:index]];
        }
     
    return optionArray;
    
    
}

-(NSMutableArray *)getSubTask:(NSString *)module :(NSString *)task{
    NSDictionary *data=[parser objectWithData:response];
    
    NSDictionary *dataforTask = [data objectForKey:module];
    
    NSDictionary *dataforSubTask = [dataforTask objectForKey:@"tasks"];
    
    NSMutableArray *subtaskArray =[[NSMutableArray alloc]init];
    
    NSArray *Subtasks = [dataforSubTask objectForKey:task];
    for(id subtask in Subtasks){
        
        
        [subtaskArray addObject:subtask];
        
    }
    return subtaskArray;
    
    
}
-(NSMutableArray *)getOptionsForSubtask:(NSString *)module :(NSString *)task :(NSString *)subtask{
    NSDictionary *data=[parser objectWithData:response];
    
    NSDictionary *dataforTask = [data objectForKey:module];
    
    NSDictionary *dataforSubTask = [dataforTask objectForKey:@"tasks"];
  
    NSDictionary *Subtasks = [dataforSubTask objectForKey:task];
    
    NSDictionary *options = [Subtasks objectForKey:subtask];
    NSMutableArray* optionsArray=[[NSMutableArray alloc]init];
    for(NSInteger i=0;i<[options count]-1;i++){
        
        NSString *index = [NSString stringWithFormat:@"%d", i];
       // NSLog(@"option: %@",[options objectForKey:index]);
        [optionsArray addObject:[options objectForKey:index]];
        
    }
    return optionsArray;
    
    
    
}




@end
