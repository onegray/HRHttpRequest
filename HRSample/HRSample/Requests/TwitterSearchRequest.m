//
//  TwitterSearchRequest.m
//  HRSample
//
//  Created by onegray on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TwitterSearchRequest.h"
#import "EGOHTTPRequest+REST.h"
#import "HRResponseParser.h"

@implementation TwitterSearchRequest

+(TwitterSearchRequest*) hrWithQuery:(NSString*)aQuery delegate:(id<TwitterSearchRequestDelegate>)aDelegate
{
    return [[[TwitterSearchRequest alloc] initWithQuery:aQuery delegate:aDelegate] autorelease];
}

-(id) initWithQuery:(NSString*)aQuery delegate:(id<TwitterSearchRequestDelegate>)aDelegate
{
    self = [super init];
    if(self)
    {
        self.delegate = aDelegate;
        self.responseParser = [[[HRJSONParser alloc] init] autorelease];
        
		NSMutableDictionary* params = [NSMutableDictionary dictionary];
		[params setObject:aQuery forKey:@"q"];
        self.httpRequest = [EGOHTTPRequest makeGetRequestToHost:nil path:@"/search" parameters:params];
    }
    return self;
}

- (void) requestDidFinishWithParsedResponseObject:(id)parsedResult
{
    TwitterSearchResponse* response = nil;
	if([self responseStatusCode]==200) {
		response = [TwitterSearchResponse responseWithParsedResult:parsedResult];
	} else {
        response = [TwitterSearchResponse responseWithStatusCodeError:[self responseStatusCode]];
    }

    if ([delegate respondsToSelector:@selector(hrTwitterSearch:didFinishWithResponse:)]) {
        [delegate hrTwitterSearch:self didFinishWithResponse:response];
    }
}

-(void) requestDidFailWithError:(NSError*)error
{
	TwitterSearchResponse* response = [TwitterSearchResponse responseWithError:error];
	if ([delegate respondsToSelector:@selector(hrTwitterSearch:didFinishWithResponse:)]) {
		[delegate hrTwitterSearch:self didFinishWithResponse:response];
	}
}



@end



@implementation TwitterSearchResponse
@synthesize searchResults;

-(id) initWithParsedResult:(id)parsedResult
{
	if(self=[super initWithParsedResult:parsedResult])
	{
        NSDictionary* resultDictionary = (NSDictionary*)[parsedResult dictionaryOrArray];
        NSArray* resultArray = [resultDictionary objectForKey:@"results"];
        NSMutableArray* results = [NSMutableArray arrayWithCapacity:[resultArray count]];
        for(NSDictionary* itemDict in resultArray) 
        {
            NSString* itemStr = [itemDict objectForKey:@"text"];
            if(itemStr)
            {
                [results addObject:itemStr];
            }
        }
        self.searchResults = results;
	}
	return self;
}

-(void) dealloc
{
    [searchResults release];
	[super dealloc];
}

@end



