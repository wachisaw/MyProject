//
//  EWIDataDecoder.h
//  EWIDemo
//
//  Created by K.Adirak on 9/24/56 BE.
//  Copyright (c) 2556 TechBerry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWIDataDecoder : NSObject


+ (NSData*)makeJsonDataFromDictionary:(NSDictionary*)dictData headerData:(NSDictionary*)header rootName:(NSString*)rootName;

+ (NSDictionary*)makeDictionaryDataFromJson:(NSData*)jsonData rootName:(NSString*)rootName;


@end
