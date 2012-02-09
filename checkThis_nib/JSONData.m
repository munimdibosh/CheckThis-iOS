//
//  GetJSONData.m
//  checkThis_nib
//
//  Created by ManGoes Mobile on 26/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "JSONData.h"

@implementation JSONData

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        parser=[[DataParser alloc] init];
    }
    
    return self;
}

-(void)getJSONDataFromServer:(NSString*)url
{
    NSURL *cheklistURL= [NSURL URLWithString:url];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] init];
    [req setURL:cheklistURL];
    conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    if (conn) {
        /*CONNECTION IS SENT,IF SUCCESSFUL,THEN INIT THE DATA.*/
        webData =[NSMutableData data];
    }
    
}

/*Data streaming has started just Now.SETTING THE LENGTH TO 0.IT will GROW WITH APPEND.*/
-(void) connection:(NSURLConnection *) connection 
didReceiveResponse:(NSURLResponse *) response {
    [webData setLength: 0];
}

/*THIS METHOD WILL BE CALLED SUCCESIVELY,SO APPENDING THE DATA.*/
-(void) connection:(NSURLConnection *) connection 
    didReceiveData:(NSData *) data {
    [webData appendData:data];
}

/*TRANSMISSION ERROR OCCURED*/
-(void) connection:(NSURLConnection *) connection 
  didFailWithError:(NSError *) error {
    
    NSLog(@"Error in transmission:%@",error);
    webData=nil;
    connection=nil;

}

/*IF SUCCESSFULLY LOADED THE DATA.*/

-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    NSLog(@"DONE. Received Bytes: %d", [webData length]);
    
    //the data should be sent to parser from here
    
    connection=nil;
    webData=nil;
}



@end
