//
//  HRMySpaceConnection.m
//  HRSample
//
//  Created by onegray on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HRMySpaceConnection.h"

static NSString* kMySpaceHost = @"http://api.myspace.com";

@implementation HRMySpaceConnection

+(HRMySpaceConnection*) sharedConnection
{
	HRMySpaceConnection* instance = (HRMySpaceConnection*)[HRConnection sharedConnectionToHost:kMySpaceHost];
	if(!instance) 
	{
		instance = [[HRMySpaceConnection alloc] initWithBaseURL:[NSURL URLWithString:kMySpaceHost]];
		[HRConnection registerConnection:instance];
	}
	return instance;
}


@end
