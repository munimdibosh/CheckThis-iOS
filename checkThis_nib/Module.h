//
//  Module.h
//  example
//
//  Created by ManGoes Mobile on 28/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Module : NSObject
{
    NSString* ID;
    NSString *name;
    NSArray *prerequisites;
    NSArray *tasks;
    
}
@property (strong,nonatomic)NSString* ID;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSArray *prerequisites;
@property(strong,nonatomic) NSArray *tasks;

@end
