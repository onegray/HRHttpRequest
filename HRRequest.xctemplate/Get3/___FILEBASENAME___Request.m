//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

#import "___FILEBASENAME___Request.h"
#import "EGOHTTPRequest+REST.h"
#import "HRResponseParser.h"

@implementation ___FILEBASENAME___Request

+(___FILEBASENAME___Request*) hrWith___VARIABLE_param1___:(NSString*)a___VARIABLE_param1___ and___VARIABLE_param2___:(NSString*)a___VARIABLE_param2___ and___VARIABLE_param3___:(NSString*)a___VARIABLE_param3___ delegate:(id<___FILEBASENAME___RequestDelegate>)aDelegate
{
    return [[[___FILEBASENAME___Request alloc] initWith___VARIABLE_param1___:a___VARIABLE_param1___ and___VARIABLE_param2___:a___VARIABLE_param2___ and___VARIABLE_param3___:a___VARIABLE_param3___ delegate:aDelegate] autorelease];
}

-(id) initWith___VARIABLE_param1___:(NSString*)a___VARIABLE_param1___ and___VARIABLE_param2___:(NSString*)a___VARIABLE_param2___ and___VARIABLE_param3___:(NSString*)a___VARIABLE_param3___ delegate:(id<___FILEBASENAME___RequestDelegate>)aDelegate
{
	self = [super init];
	if(self)
	{
		self.delegate = aDelegate;
		self.responseParser = [[[HRJSONParser alloc] init] autorelease];
        
		NSMutableDictionary* params = [NSMutableDictionary dictionary];
		[params setObject:a___VARIABLE_param1___ forKey:@"<#___VARIABLE_param1___#>"];
		[params setObject:a___VARIABLE_param2___ forKey:@"<#___VARIABLE_param2___#>"];
		[params setObject:a___VARIABLE_param3___ forKey:@"<#___VARIABLE_param3___#>"];
		self.httpRequest = [EGOHTTPRequest make___VARIABLE_restType___RequestToHost:nil path:@"<#/___FILEBASENAMEASIDENTIFIER___#>" parameters:params];
	}
	return self;
}

- (void) requestDidFinishWithParsedResponseObject:(id)parsedResult
{
	___FILEBASENAME___Response* response = nil;
	if([self responseStatusCode]==200) {
		response = [___FILEBASENAME___Response responseWithParsedResult:parsedResult];
	} else {
		response = [___FILEBASENAME___Response responseWithStatusCodeError:[self responseStatusCode]];
	}

	if ([delegate respondsToSelector:@selector(hr___FILEBASENAME___:didFinishWithResponse:)]) {
		[delegate hr___FILEBASENAME___:self didFinishWithResponse:response];
	}
}

-(void) requestDidFailWithError:(NSError*)error
{
	___FILEBASENAME___Response* response = [___FILEBASENAME___Response responseWithError:error];
	if ([delegate respondsToSelector:@selector(hr___FILEBASENAME___:didFinishWithResponse:)]) {
		[delegate hr___FILEBASENAME___:self didFinishWithResponse:response];
	}
}

@end



@implementation ___FILEBASENAME___Response

-(id) initWithParsedResult:(id)parsedResult
{
	if(self=[super initWithParsedResult:parsedResult])
	{

	}
	return self;
}

-(void) dealloc
{

	[super dealloc];
}

@end

