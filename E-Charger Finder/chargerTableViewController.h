//
//  chargerTableViewController.h
//  E-Charger Finder
//
//  Created by Adam Fallon on 07/07/2014.
//  Copyright (c) 2014 Dot.ly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chargerTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain)  NSMutableArray *rows;

@end
