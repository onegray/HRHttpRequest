//
//  MySpacePeopleSearchRequest.m
//  HRSample
//
//  Created by onegray on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MySpacePeopleSearchRequest.h"
#import "EGOHTTPRequest+REST.h"
#import "HRResponseParser.h"

@implementation MySpacePeopleSearchRequest

+(MySpacePeopleSearchRequest*) hrWithSearchTerms:(NSString*)aSearchTerms delegate:(id<MySpacePeopleSearchRequestDelegate>)aDelegate
{
    return [[[MySpacePeopleSearchRequest alloc] initWithSearchTerms:aSearchTerms delegate:aDelegate] autorelease];
}

-(id) initWithSearchTerms:(NSString*)aSearchTerms delegate:(id<MySpacePeopleSearchRequestDelegate>)aDelegate
{
	self = [super init];
	if(self)
	{
		self.delegate = aDelegate;
		self.responseParser = [[[HRJSONParser alloc] init] autorelease];
        
		NSMutableDictionary* params = [NSMutableDictionary dictionary];
		[params setObject:aSearchTerms forKey:@"searchTerms"];
		self.httpRequest = [EGOHTTPRequest makeGetRequestToHost:nil path:@"/opensearch/people" parameters:params];
	}
	return self;
}

- (void) requestDidFinishWithParsedResponseObject:(id)parsedResult
{
	MySpacePeopleSearchResponse* response = nil;
	if([self responseStatusCode]==200) {
		response = [MySpacePeopleSearchResponse responseWithParsedResult:parsedResult];
	} else {
		response = [MySpacePeopleSearchResponse responseWithStatusCodeError:[self responseStatusCode]];
	}

	if ([delegate respondsToSelector:@selector(hrMySpacePeopleSearch:didFinishWithResponse:)]) {
		[delegate hrMySpacePeopleSearch:self didFinishWithResponse:response];
	}
}

-(void) requestDidFailWithError:(NSError*)error
{
	MySpacePeopleSearchResponse* response = [MySpacePeopleSearchResponse responseWithError:error];
	if ([delegate respondsToSelector:@selector(hrMySpacePeopleSearch:didFinishWithResponse:)]) {
		[delegate hrMySpacePeopleSearch:self didFinishWithResponse:response];
	}
}

@end



@implementation MySpacePeopleSearchResponse
@synthesize searchResults;

-(id) initWithParsedResult:(id)parsedResult
{
	if(self=[super initWithParsedResult:parsedResult])
	{
        NSDictionary* resultDictionary = (NSDictionary*)[parsedResult dictionaryOrArray];
        NSArray* resultArray = [resultDictionary objectForKey:@"entry"];
        NSMutableArray* results = [NSMutableArray arrayWithCapacity:[resultArray count]];
        for(NSDictionary* itemDict in resultArray) 
        {
            NSString* itemStr = [itemDict objectForKey:@"displayName"];
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

