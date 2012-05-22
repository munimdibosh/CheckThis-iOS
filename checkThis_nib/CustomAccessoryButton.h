//
//  CustomAccessoryButton.h
//  checkThis_nib
//
//  Created by ManGoes Mobile on 10/2/12.
//  CREATED TO SUPPORT ADDING SOME PROPERTIES.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAccessoryButton : UIButton
{
    NSMutableArray *responses;
}
@property(strong,nonatomic) NSMutableArray* responses;

@end
