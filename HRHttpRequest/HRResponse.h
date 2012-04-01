//
//  HRResponse.h
//
//  Created by onegray on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HRResponse : NSObject
{
	BOOL succeed;
	NSError* error;
	int statusCode;
}
@property (nonatomic, assign) BOOL succeed;
@property (nonatomic, retain) NSError* error;
@property (nonatomic, assign) int statusCode;

+(id) responseWithParsedResult:(id)parsedResult;
+(id) responseWithError:(NSError*)error;
+(id) responseWithUnexpectedError;
+(id) responseWithStatusCodeError:(int)statusCode;
+(id) responseWithCustomErrorMessage:(NSString*)errorMsg statusCode:(int)statusCode;

-(id) initWithParsedResult:(id)parsedResult;
-(id) initWithError:(NSError*)error;

@end
