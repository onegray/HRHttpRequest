//
//  HRConnection.h
//
//  Created by onegray on 4/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@class HRRequest;

@interface HRConnection : NSObject
{
	NSMutableArray* requests;
}

+(HRConnection*) sharedConnection;

@property (nonatomic, readonly) NSURL* baseURL;

-(void) performRequest:(HRRequest*)request;
-(void) performRequest:(HRRequest*)request synchronously:(BOOL)synchronously;
-(void) finalizeRequest:(HRRequest*)request;
-(void) cancelRequestsForDelegate:(id)requestDelegate;

@end
