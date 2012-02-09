//
//  GetJSONData.h
//  checkThis_nib
//
//  Created by ManGoes Mobile on 26/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataParser.h"

@interface JSONData : NSObject
{
    NSURLConnection *conn;
    NSMutableData *webData;
    DataParser *parser;
}

-(void)getJSONDataFromServer:(NSString*)url;

@end
