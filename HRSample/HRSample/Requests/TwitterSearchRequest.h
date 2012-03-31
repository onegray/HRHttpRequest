//
//  TwitterSearchRequest.h
//  HRSample
//
//  Created by onegray on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HRRequest.h"
#import "HRResponse.h"

@class TwitterSearchRequest, TwitterSearchResponse;
@protocol TwitterSearchRequestDelegate <NSObject>
@optional
-(void) hrTwitterSearch:(TwitterSearchRequest*)request didFinishWithResponse:(TwitterSearchResponse*)response;
@end


@interface TwitterSearchRequest : HRRequest
+(TwitterSearchRequest*) hrWithQuery:(NSString*)aQuery delegate:(id<TwitterSearchRequestDelegate>)aDelegate;
-(id) initWithQuery:(NSString*)aQuery delegate:(id<TwitterSearchRequestDelegate>)aDelegate;
@end



@interface TwitterSearchResponse : HRResponse
@property (nonatomic, retain) NSArray* searchResults;
-(id) initWithParsedResult:(id)parsedResult;
@end
