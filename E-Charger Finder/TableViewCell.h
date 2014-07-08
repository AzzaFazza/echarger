//
//  TableViewCell.h
//  E-Charger Finder
//
//  Created by Adam Fallon on 08/07/2014.
//  Copyright (c) 2014 Dot.ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstLine;
@property (weak, nonatomic) IBOutlet UILabel *secondLine;
@property (weak, nonatomic) IBOutlet UILabel *thirdLine;


@end
