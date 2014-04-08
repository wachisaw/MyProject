//
//  ApprovalViewController.h
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/4/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWIJsonConnector.h"

@interface ApprovalViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, EWIConnectorDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *docNo;
@property (strong, nonatomic) NSArray *newsArray;
@property (strong, nonatomic) NSArray *newsArray2;
@property (strong, nonatomic) NSArray *newsArray3;
@property (strong) NSArray *data;
@property (strong) NSDictionary *dictionary;
@end
