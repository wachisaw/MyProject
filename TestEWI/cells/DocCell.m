//
//  DocCell.m
//  TestEWI
//
//  Created by AVIT APPLE 03 on 11/1/13.
//  Copyright (c) 2013 MSC. All rights reserved.
//

#import "DocCell.h"

@implementation DocCell

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

- (void)setNumber:(NSString *)poNo Amount:(NSString*)poAmt description:(NSString*)poDesc dds:(NSString*)poDDS typ:(NSString *)poType {
    self.poNo.text = poNo;
    self.poAmt.text = poAmt;
    self.poDesc.text = poDesc;
    self.poDDS.text = poDDS;
    self.poType.text = poType;
}

@end
