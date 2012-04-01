//
//  HRConnection.h
//
//  Created by onegray on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@class HRRequest;

@interface HRConnection : NSObject
{
	NSMutableArray* requests;
}

+(HRConnection*) sharedConnectionToHost:(NSString*)hostBaseString;
+(void) registerConnection:(HRConnection*)connection;
-(id) initWithBaseURL:(NSURL*)url;

@property (nonatomic, readonly) NSURL* baseURL;

-(void) performRequest:(HRRequest*)request;
-(void) performRequest:(HRRequest*)request synchronously:(BOOL)synchronously;
-(void) finalizeRequest:(HRRequest*)request;
-(void) cancelRequestsForDelegate:(id)requestDelegate;

@end
