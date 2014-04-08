//
//  ApprovalCell.m
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/4/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import "ApprovalCell.h"

@implementation ApprovalCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setApproval:(NSString *)approval amount:(NSString*)amount level:(NSString*)level {    self.approval.text = approval;
    self.amount.text = amount;
    self.level.text = level;
    
}

@end
