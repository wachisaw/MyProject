//
//  AccessViewController.h
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/4/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWIJsonConnector.h"

@interface AccessViewController : UIViewController<EWIConnectorDelegate>

@property (strong, nonatomic) NSString *myUserName;
@property (strong, nonatomic) NSString *myPassword;
@property (strong, nonatomic) NSString *myAccessCode;
@property (strong, nonatomic) NSString *myToken;
@property (strong, nonatomic) NSString *ewiServer;
@property (strong, nonatomic) NSString *isTest;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@property (strong, nonatomic) NSDictionary *dictionaryMenu;
@property (strong, nonatomic) NSDictionary *dictionaryDoc;
@property (strong, nonatomic) NSDictionary *dictionaryDetail;
@property (strong, nonatomic) NSDictionary *dictionaryApproval;

+ (id)shareobject;
- (NSString *)getUserName;
- (NSString *)getAccessCode;
- (NSString *)getPassword;
- (NSString *)getToken;
- (NSString *)getEWIServer;
- (BOOL)getIsTest;
- (NSDictionary *)getDictionaryMenu;
- (NSDictionary *)getDictionaryDoc;
- (NSDictionary *)getDictionaryDetail;
- (NSDictionary *)getDictionaryApproval;
- (void)stDictionaryMenu:(NSDictionary *)dictionaryMenu;
- (void)stDictionaryDoc:(NSDictionary *)dictionaryDoc;
- (void)stDictionaryDetail:(NSDictionary *)dictionaryDetail;
- (void)stDictionaryApproval:(NSDictionary *)dictionaryApproval;
- (void)refreshUserDefault;
- (void)alert:(NSString *)message;


@end
