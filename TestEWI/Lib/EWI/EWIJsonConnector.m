//
//  EWIConnector.m
//  EWIDemo
//
//  Created by K.Adirak on 9/24/56 BE.
//  Copyright (c) 2556 TechBerry. All rights reserved.
//

#import "EWIJsonConnector.h"
#import "EWIDataDecoder.h"

@interface EWIJsonConnector()

@property(strong) ASIHTTPRequest *httpRequest;

@property(strong) NSDictionary *requestData;
@property(strong) NSDictionary *responseData;

@property(strong) NSString *serviceName;
@property(strong) NSString *enpoint;

@end



@implementation EWIJsonConnector


-(void)dealloc {
    [self.httpRequest clearDelegatesAndCancel];
}


+ (EWIJsonConnector*)connector {
    
    return [[EWIJsonConnector alloc] init];
    
}


- (NSString*)serviceNameByEnpoint:(NSString*)enpoint {
    if (enpoint) {
        enpoint = [enpoint lowercaseString];
        NSRange jsonserviceRange = [enpoint rangeOfString:@"/jsonservice/"];
        if (jsonserviceRange.location != NSNotFound) {
            @try {
                NSInteger start = jsonserviceRange.location+jsonserviceRange.length;
                NSRange range = NSMakeRange(start, enpoint.length-start);
                NSString *serviceName = [enpoint substringWithRange:range];
                return serviceName;
            }
            @catch (NSException *exception) {
                NSLog(@"Service notfound! : %@", exception);
                NSLog(@"Enpoint : %@", enpoint);
            }
            
        }
    }
    return nil;
}

- (NSDictionary*)headerRequestData {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if (self.ewitoken) {
        [dict setObject:self.ewitoken forKey:@"ewitoken"];
    }
    
    if (self.workstation){
        [dict setObject:self.workstation forKey:@"workstation"];
    }
    
    if (self.usergroup){
        [dict setObject:self.usergroup forKey:@"usergroup"];
    }
    
    if (self.Username){
        [dict setObject:self.Username forKey:@"Username"];
    }
    
    return dict;
}


- (void)requestEWIService:(NSString*)endpoint requestData:(NSDictionary*)requestData {
    
    self.enpoint = endpoint;
   
    self.serviceName = [self serviceNameByEnpoint:endpoint];
    
    if(self.serviceName) {
    
        NSURL *url = [NSURL URLWithString:endpoint];
        ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        
        
        if (self.Username==nil && [requestData objectForKey:@"username"]) {
            self.Username = [requestData objectForKey:@"username"];
        }
        
        if (self.ewitoken==nil && [requestData objectForKey:@"ewitoken"]) {
            self.ewitoken = [requestData objectForKey:@"ewitoken"];
        }
        
        if (self.usergroup==nil && [requestData objectForKey:@"usergroup"]) {
            self.usergroup = [requestData objectForKey:@"usergroup"];
        }
        
        if (self.workstation==nil && [requestData objectForKey:@"workstation"]) {
            self.workstation = [requestData objectForKey:@"workstation"];
        }
        
        NSDictionary *headerDict = [self headerRequestData];
        
        NSMutableData *data = [[NSMutableData alloc] initWithData:[EWIDataDecoder makeJsonDataFromDictionary:requestData headerData:headerDict rootName:self.serviceName]];
        
        [request setPostBody:data];
        [request setDelegate:self];
        [request startAsynchronous];
        
        if (self.delegate) {
            [self.delegate requestEWIServiceStart:self];
        }
        
    }
    
    
}




- (void)requestFinished:(ASIHTTPRequest *)request {
    
    // Use when fetching binary data
    NSData *responseData = [request responseData];
    
    if (self.delegate) {
        NSDictionary *data = [EWIDataDecoder makeDictionaryDataFromJson:responseData rootName:self.serviceName];
        [self.delegate requestEWIServiceDone:self responseData:data];
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request {
   
    if (self.delegate) {
        [self.delegate requestEWIServiceFail:self];
    }
    
}



@end
