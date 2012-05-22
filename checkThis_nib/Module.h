//
//  Module.h
//  example
//
//  Created by ManGoes Mobile on 28/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Module : NSObject<NSCoding>
{
    NSString* ID;
    NSString *name;
    NSArray *prerequisites;
    NSArray *tasks;
    BOOL moduleCompleted;
    
}
@property (strong,nonatomic)NSString* ID;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSArray *prerequisites;
@property(strong,nonatomic) NSArray *tasks;
@property BOOL moduleCompleted;
-(BOOL)isCompleted;
-(void)setCompleted:(BOOL)flag;
@end
