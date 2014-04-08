//
//  ApprovalCell.h
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/4/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApprovalCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *approval;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *level;

- (void)setApproval:(NSString *)approval amount:(NSString*)amount level:(NSString*)level;
@end
