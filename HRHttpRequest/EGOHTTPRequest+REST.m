//
//  EGOHTTPRequest+REST.m
//  HRSample
//
//  Created by onegray on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HRConfig.h"
#import "EGOHTTPRequest+REST.h"
#import "EGOHTTPRequest.h"
#import "EGOHTTPFormRequest.h"

@implementation EGOHTTPRequest (REST)

+ (EGOHTTPRequest*) makeGetRequestToHost:(NSURL*)hostURL path:(NSString*)path parameters:(NSDictionary*)keyedParameters
{
	HRLog(@"building GET request with params:%@", keyedParameters);

	NSMutableArray * parameters = [NSMutableArray arrayWithCapacity:[keyedParameters count]];
	for (id key in [keyedParameters allKeys])
	{
		NSString * parameter = [NSString stringWithFormat:@"%@=%@", key, [keyedParameters valueForKey:key]];
		[parameters addObject:parameter];
	}
	
	NSURL* url = [NSURL URLWithString:[path stringByAppendingFormat:@"?%@", [parameters componentsJoinedByString:@"&"]] relativeToURL:hostURL];
    	
	EGOHTTPRequest* httpRequest = [[EGOHTTPRequest alloc] initWithURL:url];
	[httpRequest addRequestHeader:@"Accept" value:@"application/json"];
	[httpRequest addRequestHeader:@"Content-Type" value:@"application/json"];	
    
    return httpRequest;
}

+ (EGOHTTPRequest*) makePostRequestToHost:(NSURL*)hostURL path:(NSString*)path parameters:(NSDictionary*)keyedParameters
{
	HRLog(@"building POST request with params: %@", keyedParameters);

	NSURL* url = [NSURL URLWithString:path relativeToURL:hostURL];
	
	EGOHTTPRequest* httpRequest = [[EGOHTTPFormRequest alloc] initWithURL:url];
	[httpRequest addRequestHeader:@"Accept" value:@"application/json"];
	[httpRequest addRequestHeader:@"Content-Type" value:@"application/json"];	
    
	for (id key in keyedParameters)
	{
		[(EGOHTTPFormRequest*)httpRequest setPostValue:[keyedParameters objectForKey:key] forKey:key];
	}
    
    return httpRequest;
}


+ (EGOHTTPRequest*) makeMultipartFormRequestToHost:(NSURL*)hostURL path:(NSString*)path parameters:(NSDictionary*)keyedParameters
{	
	static NSString * const kBoundary = @"OxH29cHeI0jjj";
    
    NSMutableDictionary* logParams = [NSMutableDictionary dictionaryWithDictionary:keyedParameters];
    for(NSString* key in keyedParameters)
    {
        id param = [keyedParameters objectForKey:key];
        if([param isKindOfClass:[NSData class]])
        {
            [logParams setObject:[NSString stringWithFormat:@"<NSData of %d bytes long>", [param length]] forKey:key];
        }
    }
	HRLog(@"building multipart/form-data request with params: \n%@", logParams);
 
	NSURL* url = [NSURL URLWithString:path relativeToURL:hostURL];
    
	EGOHTTPRequest* httpRequest = [[EGOHTTPRequest alloc] initWithURL:url];
	httpRequest.requestMethod = @"POST";
	[httpRequest addRequestHeader:@"Content-Type" value:[NSString stringWithFormat:@"multipart/form-data; boundary=%@", kBoundary]];
    
	int dataSize = 20;
    for(id param in [keyedParameters allValues])
    {
        if([param respondsToSelector:@selector(length)])
        {
            dataSize += [param length];
        }
        dataSize += 120;
    }
    
 	NSMutableData *postData = [NSMutableData dataWithCapacity:dataSize];
    
    for(NSString* key in keyedParameters)
    {
        id param = [keyedParameters objectForKey:key];
        if([param isKindOfClass:[NSData class]])
        {
            [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
            NSString* heading = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n\r\n", key, key];
            [postData appendData:[heading dataUsingEncoding:NSUTF8StringEncoding]];
            [postData appendData:param];
            [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else if([param isKindOfClass:[NSString class]] || [param isKindOfClass:[NSNumber class]])
        {
            [postData appendData:[[NSString stringWithFormat:@"--%@\r\n", kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
            NSString* paramString = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@", key, param];
            [postData appendData:[paramString dataUsingEncoding:NSUTF8StringEncoding]];
            [postData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else
        {
            NSAssert(0, @"Unsupported class <%@> for param named <%@>", NSStringFromClass([param class]), key);
        }
    }
    
    [postData appendData:[[NSString stringWithFormat:@"--%@--\r\n", kBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [httpRequest addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%d",[postData length]]];
	[httpRequest setRequestBody:postData];
    
    return httpRequest;
}

+ (EGOHTTPRequest*) makeDeleteRequestToHost:(NSURL*)hostURL path:(NSString*)path parameters:(NSDictionary*)keyedParameters
{
	HRLog(@"building DELETE request with params:%@", keyedParameters);

	NSURL* url = [NSURL URLWithString:path relativeToURL:hostURL];
	
	EGOHTTPRequest* httpRequest = [[EGOHTTPFormRequest alloc] initWithURL:url];
	[httpRequest setRequestMethod:@"DELETE"];
	[httpRequest addRequestHeader:@"Accept" value:@"application/json"];
	[httpRequest addRequestHeader:@"Content-Type" value:@"application/json"];
    
    return httpRequest;
}



@end
