//
//  TestCase.h
//  example
//
//  Created by ManGoes Mobile on 6/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CheckList.h"
#import "Module.h"
#import "Task.h"
#import "SubTask.h"

@interface TestCase : NSObject
{
}
+(CheckList*)getTestList:(NSString*)listName;
@end
