//
//  ViewController.m
//  E-Charger Finder
//
//  Created by Adam Fallon on 07/07/2014.
//  Copyright (c) 2014 Dot.ly. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MBProgressHUD.h"
#import "CHCSVParser.h"

@interface ViewController ()
{
    GMSMapView *mapView_;
    CHCSVParser *parser;
    BOOL loadedCSV;
    MBProgressHUD * pv;


}

@end

@implementation ViewController
@synthesize rows;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *fontFamilies = [UIFont familyNames];
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:54.345539
                                                            longitude:-7.638513
                                                                 zoom:7];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;

}
-(void)viewWillAppear:(BOOL)animated {
        [self loadInCSV];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate        = self;  //SET YOUR DELEGATE HERE
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; //SET THIS TO SPECIFY THE ACCURACY
    [locationManager startUpdatingLocation];
    NSLog(newLocation);
}

-(void)loadInCSV {
    
    //Load in the CSV
    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"csv"];
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
        CHCSVParser *parser=[[CHCSVParser alloc] initWithContentsOfCSVFile:[NSHomeDirectory() stringByAppendingPathComponent:@"data.csv"] delimiter:','];
        parser.delegate = self;
        [parser parse];
        CHCSVWriter *csvWriter=[[CHCSVWriter alloc]initForWritingToCSVFile:[NSHomeDirectory() stringByAppendingPathComponent:@"data.csv"]];
        
        
        for(int i=1; i > [rows count];i++)
        {
            [csvWriter writeField:[[rows objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"0"]]];
            [csvWriter writeField:[[rows objectAtIndex:i] valueForKey:[NSString stringWithFormat:@"1"]]];
            [csvWriter finishLine];
        }
        
        
        [csvWriter closeStream];
        [self placeMarkers];
    }
}

-(void)placeMarkers {
    for (int i = 0; i < [rows count]; i++) {
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        NSString * tempCoOrds = [NSString stringWithFormat:@"%@", [rows[i] componentsJoinedByString:@","]];
        NSArray *stringArray = [tempCoOrds componentsSeparatedByString: @","];
        marker.position = CLLocationCoordinate2DMake([stringArray[0]doubleValue], [stringArray[1]doubleValue]);
        marker.title = @"LOCATION";
        marker.snippet = @"TYPE OF CHARGER";
        marker.map = mapView_;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
