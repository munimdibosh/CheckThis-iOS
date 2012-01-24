//
//  DataHolder.m
//  checkThis_nib
//
//  Created by ManGoes Mobile on 24/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DataHolder.h"
static NSString* listName;

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
@end
