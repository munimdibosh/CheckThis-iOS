//
//  TestCase.m
//  example
//
//  Created by ManGoes Mobile on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestCase.h"

@implementation TestCase

+(CheckList*)getTestList:(NSString*)ListName
{
    CheckList *list=[[CheckList alloc]init];
    list.ID=@"Unavailable";//At first set that the list is not available
    if([ListName isEqualToString:@"Surgical"])
    {

    /*
        setDataInChecklist *dt = [[setDataInChecklist alloc] init];
        NSMutableArray *modules=[dt getModule:@""];
        for (id module in modules){
            NSLog(@"module: %@",module);
     }
     */
    
    list.ID=@"1";
    list.name=@"Surgical Checklist";
    //Create a module
    Module *m1=[[Module alloc]init];
    m1.ID=@"1_1";
    m1.name=@"Before induction of anaesthesia";
    m1.prerequisites=[NSArray arrayWithObjects:@"one nurse",@"one anesthesist", nil];
    ///Create some tasks
    Task *t1=[[Task alloc]init];
    t1.ID=@"1_1_1";
    t1.name=@"Patient confirmed identity,site,procedure & consent";
    t1.options=[NSArray arrayWithObjects:@"YES", nil];
    Task *t2=[[Task alloc]init];
    t2.ID=@"1_1_2";
    t2.name=@"Is the site marked:";
    t2.options=[NSArray arrayWithObjects:@"YES",@"NOT APPLICABLE", nil];
    Task *t3=[[Task alloc]init];
    t3.ID=@"1_1_3";
    t3.name=@"Anaesthesia machine & medication check complete";
    t3.options=[NSArray arrayWithObjects:@"YES", nil];
    Task *t4=[[Task alloc] init];
    t4.ID=@"1_1_4";
    t4.name=@"Pulse oximeter on the patient and functioning and all the equipments are up,if not will check again";
    t4.options=[NSArray arrayWithObjects:@"YES",@"NO",nil];
    Task *t5=[[Task alloc] init];
    t5.ID=@"1_1_5";
    t5.name=@"Patient has a-";
    //////Add subtasks to task5
    SubTask *st1=[[SubTask alloc]init];
    st1.ID=@"1_1_5_1";
    st1.name=@"Known allergy";
    st1.options=[NSArray arrayWithObjects:@"YES",@"NO",@"May be",@"Need to test", nil];
    SubTask *st2=[[SubTask alloc]init];
    st2.ID=@"1_1_5_2";
    st2.name=@"Difficult airway or aspiration risk:";
    st2.options=[NSArray arrayWithObjects:@"YES and equipment/assistance available",@"NO", nil];
    SubTask *st3=[[SubTask alloc]init];
    st3.ID=@"1_1_5_3";
    st3.name=@"Risk of >500ml blood loss(7ml/kg in children):";
    st3.options=[NSArray arrayWithObjects:@"YES and 2 IVs/entral access & fluids planned",@"NO", nil];
    


    //
    t5.subtasks=[NSArray arrayWithObjects:st1,st2,st3, nil];
    //////add tasks to module
    m1.tasks=[NSArray arrayWithObjects:t1,t2,t3,t4,t5, nil];
    ///////add modules to list
    list.modules=[NSArray arrayWithObjects:m1, nil];

    
    }
    return list;

    
        
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end
