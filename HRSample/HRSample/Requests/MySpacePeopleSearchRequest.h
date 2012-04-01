//
//  MySpacePeopleSearchRequest.h
//  HRSample
//
//  Created by onegray on 4/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HRRequest.h"
#import "HRResponse.h"

@class MySpacePeopleSearchRequest, MySpacePeopleSearchResponse;

@protocol MySpacePeopleSearchRequestDelegate <NSObject>
@optional
-(void) hrMySpacePeopleSearch:(MySpacePeopleSearchRequest*)request didFinishWithResponse:(MySpacePeopleSearchResponse*)response;
@end


@interface MySpacePeopleSearchRequest : HRRequest
+(MySpacePeopleSearchRequest*) hrWithSearchTerms:(NSString*)aSearchTerms delegate:(id<MySpacePeopleSearchRequestDelegate>)aDelegate;
-(id) initWithSearchTerms:(NSString*)aSearchTerms delegate:(id<MySpacePeopleSearchRequestDelegate>)aDelegate;
@end



@interface MySpacePeopleSearchResponse : HRResponse
@property (nonatomic, retain) NSArray* searchResults;
-(id) initWithParsedResult:(id)parsedResult;
@end

