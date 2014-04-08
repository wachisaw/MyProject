//
//  MenuTableViewController.h
//  TestEWI
//
//  Created by AVIT APPLE 03 on 10/31/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWIJsonConnector.h"
@interface MenuTableViewController : UITableViewController<EWIConnectorDelegate>

@property(strong)NSArray *data;

+ (id)shareobject;
- (void) getMenuList;
- (void) closeMe;

@end
