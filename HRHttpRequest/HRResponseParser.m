//
//  HRResponseParser.m
//  HRSample
//
//  Created by onegray on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HRResponseParser.h"
#import "NSDictionary_JSONExtensions.h"
#import "TouchXML.h"

#define kHRParserErrorDomain @"com.httprequest.parser.error"


@implementation HRJSONParsedResult
@synthesize dictionaryOrArray;

-(void) dealloc
{
    //NSLog(@"[%@ dealloc]", self);
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



@implementation HRJSONParser

-(HRJSONParsedResult*) parseResponseData:(NSData*)data error:(NSError**)errorPointer 
{
    HRJSONParsedResult* parsedResult = [[[HRJSONParsedResult alloc] init] autorelease];
    id parsedObj = [NSDictionary dictionaryWithJSONData:data error:nil];
    if(![parsedObj isKindOfClass:[NSDictionary class]] && ![parsedObj isKindOfClass:[NSArray class]])
    {
        NSString* errMsg = [NSString stringWithFormat:@"Inappropriate object %@", parsedObj]; 
        NSDictionary* errorInfo = [NSDictionary dictionaryWithObject:errMsg forKey:NSLocalizedDescriptionKey];
        *errorPointer = [NSError errorWithDomain:kHRParserErrorDomain code:100 userInfo:errorInfo];
        return nil;
    }
	parsedResult.dictionaryOrArray = parsedObj;
    return parsedResult;
}

@end




@implementation HRXMLParsedResult
@synthesize xml;

-(void) dealloc
{
    [xml release];
    [super dealloc];
}

@end


@implementation HRXMLParser

-(HRXMLParsedResult*) parseResponseData:(NSData*)data error:(NSError**)errorPointer
{
    HRXMLParsedResult* parsedResult = [[[HRXMLParsedResult alloc] init] autorelease];
    parsedResult.xml = [[[CXMLDocument alloc] initWithData:data options:0 error:errorPointer] autorelease];
    return *errorPointer==nil ? parsedResult : nil;
}


@end






