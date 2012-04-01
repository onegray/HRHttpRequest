//
//  HRTwitterConnection.m
//  HRSample
//
//  Created by onegray on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HRTwitterConnection.h"

static NSString* kTwiterHost = @"http://search.twitter.com";

@implementation HRTwitterConnection

+(HRTwitterConnection*) sharedConnection
{
	HRTwitterConnection* instance = (HRTwitterConnection*)[HRConnection sharedConnectionToHost:kTwiterHost];
	if(!instance) 
	{
		instance = [[HRTwitterConnection alloc] initWithBaseURL:[NSURL URLWithString:kTwiterHost]];
		[HRConnection registerConnection:instance];
	}
	return instance;
}


@end
