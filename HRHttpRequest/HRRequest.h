//
//  HRRequest.h
//
//  Created by onegray on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HRResponseParserProtocol;
@class EGOHTTPRequest;
@class HRConnection;

@interface HRRequest : NSObject
{
	EGOHTTPRequest* httpRequest;
	HRConnection* connection;
    id<HRResponseParserProtocol>responseParser;
	id delegate;
}

@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) HRConnection* connection;
@property (nonatomic, retain) EGOHTTPRequest* httpRequest;
@property (nonatomic, retain) id<HRResponseParserProtocol>responseParser;

- (void) startSynchronously:(BOOL)synchronous;
- (int) responseStatusCode;
- (void) cancel;


#pragma mark -
#pragma mark Overloading request handlers

- (void) requestDidFinishWithParsedResponseObject:(id)parsedResult;
- (void) requestDidFailWithError:(NSError*)error;
- (void) requestDidFinalize;


@end
