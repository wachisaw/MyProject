//
//  EWIConnector.h
//  EWIDemo
//
//  Created by K.Adirak on 9/24/56 BE.
//  Copyright (c) 2556 TechBerry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"


@class EWIJsonConnector;


@protocol EWIConnectorDelegate <NSObject>

- (void)requestEWIServiceStart:(EWIJsonConnector*)connector;
- (void)requestEWIServiceDone:(EWIJsonConnector*)connector responseData:(NSDictionary*)responseData;
- (void)requestEWIServiceFail:(EWIJsonConnector*)connector;

@end

@interface EWIJsonConnector : NSObject <ASIHTTPRequestDelegate>

@property(readonly) ASIHTTPRequest *httpRequest;

@property(readonly) NSDictionary *requestData;
@property(readonly) NSDictionary *responseData;

@property(readonly) NSString *enpoint;

@property(strong) NSString *ewitoken;
@property(strong) NSString *workstation;
@property(strong) NSString *usergroup;
@property(strong) NSString *Username;


@property(strong) id<EWIConnectorDelegate> delegate;


- (void)requestEWIService:(NSString*)endpoint requestData:(NSDictionary*)requestData;


+ (EWIJsonConnector*)connector;


@end
