//
//  HRResponseParser.h
//  HRSample
//
//  Created by onegray on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

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

@interface HRJSONParser : NSObject <HRResponseParserProtocol>
-(HRJSONParsedResult*) parseResponseData:(NSData*)data error:(NSError**)errorPointer;
@end


// XML parsers

@class CXMLDocument;
@interface HRXMLParsedResult : NSObject
@property (nonatomic, retain) CXMLDocument* xml;
@end


@interface HRXMLParser : NSObject <HRResponseParserProtocol>
-(HRXMLParsedResult*) parseResponseData:(NSData*)data error:(NSError**)errorPointer;
@end


