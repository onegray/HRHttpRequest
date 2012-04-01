//
//  HRRequest.m
//
//  Created by onegray on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HRConfig.h"
#import "HRRequest.h"
#import "HRConnection.h"
#import "EGOHTTPRequest.h"
#import "EGOHTTPFormRequest.h"
#import "HRResponseParser.h"

@interface EGOHTTPRequest (extension)
- (BOOL) reset;
- (void) setTargetHost:(NSURL*)hostUrl;
@end

@implementation EGOHTTPRequest (extension)

- (BOOL) reset {
    if(isFinished) {
        [_responseData setLength:0];
        isStarted = NO;
        isCancelled = NO;
        isFinished = NO;
        return YES;
    }
    return NO;
}

-(void) setTargetHost:(NSURL*)hostUrl {
    NSString* path = [[[_URL relativeString] retain] autorelease];
    [_URL release];
    _URL = [[NSURL alloc] initWithString:path relativeToURL:hostUrl];
}

@end


@implementation HRRequest
@synthesize delegate;
@synthesize connection;
@synthesize responseParser;
@synthesize httpRequest;

-(void) dealloc
{
	[httpRequest release];
    [responseParser release];
	[super dealloc];
}

- (void)startSynchronously:(BOOL)synchronous
{
    if(httpRequest.finished) {
        [httpRequest reset];
        [httpRequest setDelegate:self];
    }

    if([httpRequest.url baseURL]==nil) {
        [httpRequest setTargetHost:connection.baseURL];
    }
    
    httpRequest.delegate = self;
    [httpRequest setDidFinishSelector:@selector(httpRequestDidFinish:)];
	[httpRequest setDidFailSelector:@selector(httpRequestDidFail:withError:)];
    [httpRequest setDidCancelSelector:@selector(httpRequestDidCancel:)];

	HRLog(@"Starting request %@ to: %@", httpRequest, [httpRequest.url absoluteString]);
    
	if(synchronous) {
		[httpRequest startSynchronous];
	} else {
		[httpRequest startAsynchronous];
	}
}

-(int) responseStatusCode
{
	return httpRequest.responseStatusCode;
}

-(void) cancel
{
	[httpRequest cancel];
}

#pragma mark -
#pragma mark EGOHTTPRequest delegate 

- (void)httpRequestDidFinish:(EGOHTTPRequest*)aRequest
{
	HRLog(@"httpRequestDidFinish:%@  - %d", aRequest, [aRequest responseStatusCode]);
	
#if HR_VERBOSE_TRAFFIC
	HRLog(@"Response data:\n%@\n-", aRequest.responseString);
#endif	
	
    NSError* error = nil;
    id parsedResult = [responseParser parseResponseData:aRequest.responseData error:&error];

    if(aRequest.cancelled)
    {
        [self performSelectorOnMainThread:@selector(httpRequestDidCancelOnMainThread) withObject:nil waitUntilDone:NO];
    }
    else if(error)
    {
		[self performSelectorOnMainThread:@selector(httpRequestDidFailOnMainThreadWithError:)
							   withObject:error waitUntilDone:NO];
    }
    else
	{
		[self performSelectorOnMainThread:@selector(httpRequestDidFinishOnMainThreadWithParsedResponseObject:)
							   withObject:parsedResult waitUntilDone:NO];
	}
}

- (void)httpRequestDidFail:(EGOHTTPRequest*)aRequest withError:(NSError *)error
{
	HRLog(@"httpRequestDidFail:%@ withError:%@", aRequest, error);
    
	if(!aRequest.cancelled)
	{
		[self performSelectorOnMainThread:@selector(httpRequestDidFailOnMainThreadWithError:)
							   withObject:error waitUntilDone:NO];
	}
    else
    {
        [self performSelectorOnMainThread:@selector(httpRequestDidCancelOnMainThread) withObject:nil waitUntilDone:NO];
    }
}

- (void)httpRequestDidCancel:(EGOHTTPRequest*)aRequest
{
	HRLog(@"httpRequestDidCancel:%@", aRequest);
    [self performSelectorOnMainThread:@selector(httpRequestDidCancelOnMainThread) withObject:nil waitUntilDone:NO];
}

-(void) httpRequestDidFinishOnMainThreadWithParsedResponseObject:(id)parsedResult
{
	HRLog(@"httpRequestDidFinishOnMainThreadWithParsedResponseObject (%@)", self);
#if HR_VERBOSE_TRAFFIC
	HRLog(@"ParsedResponseObject:\n%@", parsedResult);
#endif	

	if(!httpRequest.cancelled)
	{
		[self requestDidFinishWithParsedResponseObject:parsedResult];
	}
	else 
	{
		HRLog(@"Request was cancelled (%@)", self);
	}
    
    [self retain];
	[connection finalizeRequest:self];
    [self requestDidFinalize];
    [self release];
}

-(void) httpRequestDidFailOnMainThreadWithError:(NSError*)error
{
	HRLog(@"httpRequestDidFailOnMainThreadWithError(%@): %@", self, [error localizedDescription]);
	if(!httpRequest.cancelled)
	{
		[self requestDidFailWithError:error];
	}
	else 
	{
		HRLog(@"Request was cancelled (%@)", self);
	}

    [self retain];
	[connection finalizeRequest:self];
    [self requestDidFinalize];
    [self release];
}

-(void) httpRequestDidCancelOnMainThread
{
	HRLog(@"httpRequestDidCancelOnMainThread (%@)", self);
	
    [self retain];
	[connection finalizeRequest:self];
    [self requestDidFinalize];
    [self release];
}


#pragma mark -
#pragma mark Overloading request handlers

-(void) requestDidFinishWithParsedResponseObject:(id)parsedResult
{
}

-(void) requestDidFailWithError:(NSError*)error
{
}

-(void) requestDidFinalize
{
}

@end
