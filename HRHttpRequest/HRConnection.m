//
//  HRConnection.m
//
//  Created by onegray on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HRConnection.h"
#import "HRRequest.h"
#import "EGOHTTPRequest.h"

static NSMutableDictionary* connectionPool;

@implementation HRConnection
@synthesize baseURL;

+(HRConnection*) sharedConnectionToHost:(NSString*)hostBaseString 
{
	return [connectionPool objectForKey:hostBaseString];
}

+(void) registerConnection:(HRConnection*)connection
{
	if(!connectionPool) 
	{
		connectionPool = [[NSMutableDictionary alloc] initWithCapacity:1];
	}
	[connectionPool setObject:connection forKey:[[connection baseURL] absoluteString]];
}

-(id) initWithBaseURL:(NSURL*)url
{
	if(self=[super init])
	{
		requests = [[NSMutableArray alloc] init];
        baseURL = [url retain];
	}
	return self;
}

-(void) dealloc
{
	[requests release];
	[baseURL release];
	[super dealloc];
}

-(void) performRequest:(HRRequest*)request
{
	[self performRequest:request synchronously:NO];
}

-(void) performRequest:(HRRequest*)request synchronously:(BOOL)synchronously
{
	request.connection = self;
	[requests addObject:request];
	[request startSynchronously:synchronously];
}

-(void) finalizeRequest:(HRRequest*)request
{
	[requests removeObject:request];
}

-(void)cancelRequestsForDelegate:(id)requestDelegate
{
	NSLog(@"HRConnection cancelRequestsForDelegate: %@", requestDelegate);
	
	NSArray* requestsCopy = [NSArray arrayWithArray:requests];
	for(HRRequest* request in requestsCopy)
	{
		if (request.delegate == requestDelegate)
		{
			NSLog(@"HRConnection: cancelling request: %@", request);
			[request cancel];
		}
	}
}

@end



