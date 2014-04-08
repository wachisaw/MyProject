//
//  MenuViewController.h
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/1/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWIJsonConnector.h"

@interface MenuViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, EWIConnectorDelegate>

@property (strong, nonatomic) NSArray *newsArray;
@property (strong, nonatomic) NSArray *newsArray2;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong) NSArray *data;
@property (strong) NSDictionary *dictionary;

@end
