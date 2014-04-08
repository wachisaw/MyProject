//
//  ViewController.h
//  TestEWI
//
//  Created by AVIT APPLE 03 on 10/31/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWIJsonConnector.h"

//<EWI...> added by manually
@interface ViewController : UIViewController<EWIConnectorDelegate>

+ (id)shareobject;
- (NSString *)getUserName;
- (NSString *)getPassword;
- (NSString *)getToken;
- (void) closeMe;
- (void) clearPassword;

@end
