//
//  HRResponse.m
//
//  Created by onegray on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HRResponse.h"

static NSString* kHRErrorDomain = @"com.httprequest.error";

@implementation HRResponse
@synthesize succeed, error, statusCode;

+(id) responseWithParsedResult:(id)parsedResult
{
	return [[[self alloc] initWithParsedResult:parsedResult] autorelease];
}

+(id) responseWithError:(NSError*)anError
{
	return [[[self alloc] initWithError:anError] autorelease];
}

+(id) responseWithUnexpectedError
{
	NSString* errorMsg = @"Unexpected error";
	NSDictionary* errorInfo = [NSDictionary dictionaryWithObject:errorMsg forKey:NSLocalizedDescriptionKey];
	NSError* anError = [NSError errorWithDomain:kHRErrorDomain code:100 userInfo:errorInfo];
	return [[[self alloc] initWithError:anError] autorelease];
}

+(id) responseWithStatusCodeError:(int)statusCode
{
	NSString* errorMsg = [NSString stringWithFormat:@"Unexpected server response (status code %d)", statusCode];
	NSDictionary* errorInfo = [NSDictionary dictionaryWithObject:errorMsg forKey:NSLocalizedDescriptionKey];
	NSError* anError = [NSError errorWithDomain:kHRErrorDomain code:101 userInfo:errorInfo];
	HRResponse* response = [[[self alloc] initWithError:anError] autorelease];
	response.statusCode = statusCode;
	return response;
}

+(id) responseWithCustomErrorMessage:(NSString*)errorMsg statusCode:(int)statusCode
{
	NSDictionary* errorInfo = [NSDictionary dictionaryWithObject:errorMsg forKey:NSLocalizedDescriptionKey];
	NSError* anError = [NSError errorWithDomain:kHRErrorDomain code:101 userInfo:errorInfo];
	HRResponse* response = [[[self alloc] initWithError:anError] autorelease];
	response.statusCode = statusCode;
	return response;
}


-(id) initWithParsedResult:(id)parsedResult
{
	if(self=[super init])
	{
		self.succeed = YES;
	}
	return self;
}

-(id) initWithError:(NSError*)anError
{
	if(self=[super init])
	{
		self.succeed = NO;
		self.error = anError;
	}
	return self;
}


-(void) dealloc
{
	[error release];
	[super dealloc];
}


@end
