//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

#import "HRRequest.h"
#import "HRResponse.h"

@class ___FILEBASENAME___Request, ___FILEBASENAME___Response;

@protocol ___FILEBASENAME___RequestDelegate <NSObject>
@optional
-(void) hr___FILEBASENAME___:(___FILEBASENAME___Request*)request didFinishWithResponse:(___FILEBASENAME___Response*)response;
@end


@interface ___FILEBASENAME___Request : HRRequest
+(___FILEBASENAME___Request*) hrWith___VARIABLE_param1___:(NSString*)a___VARIABLE_param1___ and___VARIABLE_param2___:(NSString*)a___VARIABLE_param2___ delegate:(id<___FILEBASENAME___RequestDelegate>)aDelegate;
-(id) initWith___VARIABLE_param1___:(NSString*)a___VARIABLE_param1___ and___VARIABLE_param2___:(NSString*)a___VARIABLE_param2___ delegate:(id<___FILEBASENAME___RequestDelegate>)aDelegate;
@end



@interface ___FILEBASENAME___Response : HRResponse
-(id) initWithParsedResult:(id)parsedResult;
@end

