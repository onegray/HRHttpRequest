//
//  HRResponseParser.h
//  HRSample
//
//  Created by onegray on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HRConfig.h"
#import <Foundation/Foundation.h>


// generic interface

@protocol HRResponseParserProtocol <NSObject>
@required
-(id) parseResponseData:(NSData*)data error:(NSError**)errorPointer;
@end



// JSON parsers

@interface HRJSONParsedResult : NSObject
@property (nonatomic, retain) id dictionaryOrArray;
@end

#if HR_USE_TOUCHJSON_PARSER
@interface HRJSONParser : NSObject <HRResponseParserProtocol>
-(HRJSONParsedResult*) parseResponseData:(NSData*)data error:(NSError**)errorPointer;
@end
#endif



// XML parsers

@class CXMLDocument;
@interface HRXMLParsedResult : NSObject
@property (nonatomic, retain) CXMLDocument* xml;
@end

#if HR_USE_TOUCHXML_PARSER
@interface HRXMLParser : NSObject <HRResponseParserProtocol>
-(HRXMLParsedResult*) parseResponseData:(NSData*)data error:(NSError**)errorPointer;
@end
#endif

