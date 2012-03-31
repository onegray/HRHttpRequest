//
//  HRConnection.m
//
//  Created by onegray on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HRConnection.h"
#import "HRRequest.h"
#import "EGOHTTPRequest.h"

static HRConnection* instance = nil;

@implementation HRConnection
@synthesize baseURL;

+(HRConnection*) sharedConnection
{
	if(instance==nil)
	{
		instance = [[HRConnection alloc] init];
	}
	return instance;
}

-(id) init
{
	if(self=[super init])
	{
		requests = [[NSMutableArray alloc] init];
        baseURL = [NSURL URLWithString:@"http://search.twitter.com"];
	}
	return self;
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



