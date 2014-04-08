//
//  DetailViewController.h
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/2/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EWIJsonConnector.h"

@interface DetailViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,EWIConnectorDelegate>


@property (strong, nonatomic) NSArray *newsArray;
@property (strong, nonatomic) NSArray *newsArray2;
@property (strong, nonatomic) NSArray *newsArray3;
@property (strong, nonatomic) NSArray *newsArray4;
@property (strong, nonatomic) NSArray *newsArray5;
@property (weak, nonatomic) IBOutlet UILabel *docNo;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong) NSArray *data;
@property (strong) NSDictionary *dictionary;
@property (strong) NSString *willCloseNextAppear;

+ (id)shareobject;
- (void) stWillCloseNextAppear:(NSString *)willCloseNextAppear;

@end
