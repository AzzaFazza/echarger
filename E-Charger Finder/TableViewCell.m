//
//  TableViewCell.m
//  E-Charger Finder
//
//  Created by Adam Fallon on 08/07/2014.
//  Copyright (c) 2014 Dot.ly. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell
@synthesize firstLine, secondLine, thirdLine;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
