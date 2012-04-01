//
//  HRResponseParser.m
//  HRSample
//
//  Created by onegray on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HRConfig.h"
#import "HRResponseParser.h"
#import "NSDictionary_JSONExtensions.h"
#import "TouchXML.h"

#define kHRParserErrorDomain @"com.httprequest.parser.error"


@implementation HRJSONParsedResult
@synthesize dictionaryOrArray;

-(void) dealloc
{
    [dictionaryOrArray release];
    [super dealloc];
}

-(void) setDictionaryOrArray:(id)obj 
{
    if(obj!=dictionaryOrArray)
    {
        NSAssert([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]], @"Invalid param");
        [dictionaryOrArray release];
        dictionaryOrArray = [obj retain];
    }
}

@end


#if HR_USE_TOUCHJSON_PARSER
@implementation HRJSONParser

-(HRJSONParsedResult*) parseResponseData:(NSData*)data error:(NSError**)errorPointer 
{
	*errorPointer = nil;
    id parsedObj = [NSDictionary dictionaryWithJSONData:data error:errorPointer];
	if(*errorPointer!=nil) 
	{
		HRLog(@"HRJSONParser parseResponseData failed with error: %@", [*errorPointer localizedDescription]);
		return nil;
	}
	
    if(![parsedObj isKindOfClass:[NSDictionary class]] && ![parsedObj isKindOfClass:[NSArray class]])
    {
        NSString* errMsg = [NSString stringWithFormat:@"Inappropriate object class %@", NSStringFromClass([parsedObj class])];
        NSDictionary* errorInfo = [NSDictionary dictionaryWithObject:errMsg forKey:NSLocalizedDescriptionKey];
        *errorPointer = [NSError errorWithDomain:kHRParserErrorDomain code:100 userInfo:errorInfo];
		HRLog(@"HRJSONParser parseResponseData failed with error: %@", [*errorPointer localizedDescription]);
        return nil;
    }

    HRJSONParsedResult* parsedResult = [[[HRJSONParsedResult alloc] init] autorelease];
	parsedResult.dictionaryOrArray = parsedObj;
    return parsedResult;
}

@end
#endif



@implementation HRXMLParsedResult
@synthesize xml;

-(void) dealloc
{
    [xml release];
    [super dealloc];
}

@end


#if HR_USE_TOUCHXML_PARSER
@implementation HRXMLParser

-(HRXMLParsedResult*) parseResponseData:(NSData*)data error:(NSError**)errorPointer
{
	*errorPointer = nil;
    HRXMLParsedResult* parsedResult = [[[HRXMLParsedResult alloc] init] autorelease];
    parsedResult.xml = [[[CXMLDocument alloc] initWithData:data options:0 error:errorPointer] autorelease];
	if(*errorPointer!=nil) 
	{
		HRLog(@"HRXMLParser parseResponseData failed with error: %@", [*errorPointer localizedDescription]);
		return nil;
	}
    return parsedResult;
}


@end
#endif


