//
//  SubTask.h
//  example
//
//  Created by ManGoes Mobile on 28/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubTask : NSObject
{
    NSString* ID;
    NSString *name;
    NSArray *options;
    NSArray *responses;
}
@property (strong,nonatomic)NSString* ID;
@property(strong,nonatomic) NSString *name;
@property(strong,nonatomic) NSArray *options;
@property(strong,nonatomic) NSArray *responses;


@end
