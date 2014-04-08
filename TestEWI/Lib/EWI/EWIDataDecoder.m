//
//  EWIDataDecoder.m
//  EWIDemo
//
//  Created by K.Adirak on 9/24/56 BE.
//  Copyright (c) 2556 TechBerry. All rights reserved.
//

#import "EWIDataDecoder.h"

@implementation EWIDataDecoder

+ (NSData*)makeJsonDataFromDictionary:(NSDictionary*)dictData headerData:(NSDictionary*)header rootName:(NSString*)rootName {
    
    rootName = [rootName lowercaseString];
    
    NSMutableDictionary *ewiDictData = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *requestDict = [[NSMutableDictionary alloc] init];
    [ewiDictData setObject:requestDict forKey:[NSString stringWithFormat:@"%@Request",rootName]];
    
    [requestDict setObject:dictData forKey:@"content"];
    
    if (header) {
        
        // Fix Username
        if ([header objectForKey:@"Username"]) {
            [requestDict setObject:[header objectForKey:@"Username"] forKey:@"Username"];
        }
        
        // Fix ewitoken
        if ([header objectForKey:@"ewitoken"]) {
            [requestDict setObject:[header objectForKey:@"ewitoken"] forKey:@"ewitoken"];
        }
        
        // Fix workstation
        if ([header objectForKey:@"workstation"]) {
            [requestDict setObject:[header objectForKey:@"workstation"] forKey:@"workstation"];
        }
        
        // Fix workstation
        if ([header objectForKey:@"usergroup"]) {
            [requestDict setObject:[header objectForKey:@"usergroup"] forKey:@"usergroup"];
        }
        
    }

    
   
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:ewiDictData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    
    NSLog(@"\nRequest = %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
    if (!jsonData) {
        NSLog(@"Make Json data error: %@", error);
    } else {
        return jsonData;
    }
    
    return nil;
}


+ (NSDictionary*)makeDictionaryDataFromJson:(NSData*)jsonData rootName:(NSString*)rootName {
    
    
    //NSLog(@"Json = \n%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
    rootName = [rootName lowercaseString];
    
    NSError *error;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    
    if (!jsonDict) {
        NSLog(@"Make Dictionary data error: %@", error);
    } else {
        
        
        NSString *serviceResponse = [NSString stringWithFormat:@"%@Response",rootName];
        
        NSMutableDictionary *responseDict = [jsonDict objectForKey:serviceResponse];
        
        if (responseDict) {
            
            NSMutableDictionary *contentDict = [[NSMutableDictionary alloc] init];

            // Add content
            if ([responseDict objectForKey:@"content"]) {
                [contentDict setObject:[responseDict objectForKey:@"content"] forKey:@"content"];
            }
            
            // Add Returncode
            if ([responseDict objectForKey:@"Returncode"]) {
                [contentDict setObject:[responseDict objectForKey:@"Returncode"] forKey:@"Returncode"];
            }
            
            // Add Runmessage
            if ([responseDict objectForKey:@"Runmessage"]) {
                [contentDict setObject:[responseDict objectForKey:@"Runmessage"] forKey:@"Runmessage"];
            }
            
            //NSLog(@"\n%@", contentDict);
        
            return contentDict;
            
        }
        
        
        
    }
    
    return nil;
    
}

@end
