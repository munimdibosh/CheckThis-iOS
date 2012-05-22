//
//  SubTask.h
//  example
//
//  Created by ManGoes Mobile on 28/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface SubTask : NSObject<NSCoding>
{
    NSString* ID;
    NSString *name;
    NSArray *options;
    NSMutableArray *responses;
}
@property (strong,nonatomic)NSString* ID;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSArray *options;
@property(strong,nonatomic) NSMutableArray *responses;


@end
