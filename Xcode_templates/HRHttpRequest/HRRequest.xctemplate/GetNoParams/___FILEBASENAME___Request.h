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
+(___FILEBASENAME___Request*) hrWithDelegate:(id<___FILEBASENAME___RequestDelegate>)aDelegate;
-(id) initWithDelegate:(id<___FILEBASENAME___RequestDelegate>)aDelegate;
@end



@interface ___FILEBASENAME___Response : HRResponse
-(id) initWithParsedResult:(id)parsedResult;
@end

