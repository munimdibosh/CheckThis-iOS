//
//  CheckList.h
//  example
//
//  Created by ManGoes Mobile on 28/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Module.h"

@interface CheckList : NSObject<NSCoding>
{
    NSString *ID;
    NSString *name;
    NSArray *modules;
}
@property (strong,nonatomic) NSString *ID;
@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSArray *modules;
-(BOOL)isModuleAvailable:(int)modNum;
-(BOOL)isCompleted;

@end
