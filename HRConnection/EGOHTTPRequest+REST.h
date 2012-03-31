//
//  EGOHTTPRequest+REST.h
//  HRSample
//
//  Created by onegray on 3/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EGOHTTPRequest.h"

@interface EGOHTTPRequest (REST)

+ (EGOHTTPRequest*) makeGetRequestToHost:(NSURL*)hostURL path:(NSString*)path parameters:(NSDictionary*)keyedParameters;
+ (EGOHTTPRequest*) makePostRequestToHost:(NSURL*)hostURL path:(NSString*)path parameters:(NSDictionary*)keyedParameters;
+ (EGOHTTPRequest*) makeMultipartFormRequestToHost:(NSURL*)hostURL path:(NSString*)path parameters:(NSDictionary*)keyedParameters;
+ (EGOHTTPRequest*) makeDeleteRequestToHost:(NSURL*)hostURL path:(NSString*)path parameters:(NSDictionary*)keyedParameters;

@end
