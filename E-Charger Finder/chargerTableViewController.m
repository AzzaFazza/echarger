//
//  chargerTableViewController.m
//  E-Charger Finder
//
//  Created by Adam Fallon on 07/07/2014.
//  Copyright (c) 2014 Dot.ly. All rights reserved.
//

#import "chargerTableViewController.h"
#import "CHCSVParser.h"
#import "MBProgressHUD.h"
#import "TableViewCell.h"

@interface chargerTableViewController ()
{
    CHCSVParser *parser;
    BOOL loadedCSV;
    MBProgressHUD * pv;
}

@end

@implementation chargerTableViewController
@synthesize rows;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    loadedCSV = false;
}
-(void)viewWillAppear:(BOOL)animated {
    [self loadInCSV];
    [self.tableView reloadData];
}
-(void)loadInCSV {
    
    //Progress Identifier
    if(loadedCSV == false) {
        pv = [[MBProgressHUD alloc]initWithView:self.navigationController.view];
        [self.navigationController.view addSubview:pv];
        pv.dimBackground = YES;
        pv.delegate = self;
        pv.labelText = @"Locating";
        [pv show:YES];
    } else {
        [pv hide:YES];
    }
    
    //Load in the CSV
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dataFull" ofType:@"csv"];
    NSError *error = nil;
    rows = [NSMutableArray arrayWithContentsOfCSVFile:path];
    if (rows == nil) {
        //something went wrong; log the error and exit
        NSLog(@"error parsing file: %@", error);
        return;
    } else {
        parser = [[CHCSVParser alloc]initWithContentsOfCSVFile:path];
        NSLog(@"Loading Data: Successful");
        loadedCSV = true;
        [pv hide:true];
        CHCSVParser *parser=[[CHCSVParser alloc] initWithContentsOfCSVFile:[NSHomeDirectory() stringByAppendingPathComponent:@"l.csv"] delimiter:','];
        parser.delegate = self;
        [parser parse];
        CHCSVWriter *csvWriter=[[CHCSVWriter alloc]initForWritingToCSVFile:[NSHomeDirectory() stringByAppendingPathComponent:@"dataFull.csv"]];
        NSLog(@"%d",[rows count]);
        
        
        for(int i=1; i > [rows count];i++)
        {
            [csvWriter writeField:[[rows objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"0"]]];
            [csvWriter writeField:[[rows objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"1"]]];
            [csvWriter writeField:[[rows objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"2"]]];
            [csvWriter writeField:[[rows objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"3"]]];
            [csvWriter writeField:[[rows objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"6"]]];
            [csvWriter writeField:[[rows objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"7"]]];
            [csvWriter finishLine];
        }

        
        [csvWriter closeStream];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [rows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TableViewCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }//if the cell is nil (not allocated memory) allocate it memory and initialise with with the default style and the CellIdentifier
    
    NSArray *s1 =  [rows objectAtIndex:indexPath.row];
    
    
    NSString * temp = [NSString stringWithFormat:@"%@", [s1 componentsJoinedByString:@","]];
//    cell.textLabel.text = temp;
    cell.firstLine.text = temp;
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
