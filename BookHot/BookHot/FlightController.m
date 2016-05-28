//
//  FlightController.m
//  BookHot
//
//  Created by Admin on 27.05.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "FlightController.h"
#import "Trip.h"
@interface FlightController (){
    int isCity;
    MKPointAnnotation *annotatiionFrom;
    MKPointAnnotation *annotatiionTo;
    NSMutableArray *resultFlights;
}
@property (strong, nonatomic) IBOutlet MKMapView *map;
@property (strong, nonatomic) IBOutlet UITextField *cityFrom;
@property (strong, nonatomic) IBOutlet UITextField *cityTo;
@property (strong, nonatomic) IBOutlet UITableView *listOfFlights;

@property (strong, nonatomic) IBOutlet UILabel *text;

@end

@implementation FlightController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILongPressGestureRecognizer *longPressGesture =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.map addGestureRecognizer:longPressGesture];
    isCity = 2;
    resultFlights = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleLongPressGesture:(UIGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint point = [sender locationInView:self.map];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        CLLocationCoordinate2D coord = [self.map convertPoint:point
                                         toCoordinateFromView:self.map];
        CLLocation *location = [[CLLocation alloc]
                                initWithLatitude:coord.latitude longitude:coord.longitude];
        [geocoder reverseGeocodeLocation:location
                       completionHandler:^(NSArray *placemarks, NSError *error)
         {
             if (error)
             {
                 NSLog(@"Geocode failed with error: %@", error);
                 return;
             }
             for (CLPlacemark * placemark in placemarks)
             {
                 [self setAnnotationToMap:isCity :placemark.locality:coord];
             }
         }];
        if(isCity == 1)
            isCity = 2;
        else
            isCity = 1;
    }
}
-(void)setAnnotationToMap:(int)type :(NSString *)title
                         :(CLLocationCoordinate2D)coordinate
{
    if (type == 1) {
        [_map removeAnnotation:annotatiionFrom];
        annotatiionFrom= [[MKPointAnnotation alloc] init];
        annotatiionFrom.title = title;
        annotatiionFrom.coordinate = coordinate;
        [_map addAnnotation:annotatiionFrom];
        self.cityFrom.text = title;
    }
    else
    {
        [_map removeAnnotation:annotatiionTo];
        annotatiionTo= [[MKPointAnnotation alloc] init];
        annotatiionTo.title = title;
        annotatiionTo.coordinate = coordinate;
        [_map addAnnotation:annotatiionTo];
        self.cityTo.text = title;
    }
}
- (IBAction)showTrips:(id)sender {
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    resultFlights = [app getFlightsWithCityFrom:[_cityFrom text] andCityTo:[_cityTo text]];
    if([resultFlights count] > 0) {
        [_text setText:[NSString stringWithFormat:@"Flights found: %lu", [resultFlights count]]];
        [_listOfFlights reloadData];
    }
    else {
        [_text setText:@"No flights found"];
        [_listOfFlights reloadData];
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(resultFlights == nil) {
        return 0;
    }
    return [resultFlights count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    //Поиск ячейки
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //Если ячейка не найдена
    if (cell == nil) {
        //Создание ячейки
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    Trip *rec = (Trip *)[resultFlights objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@: %@ - %@",rec.company, rec.price,rec.transport];
    
    return cell;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.cityFrom)
        isCity = 2;
    else if (textField == self.cityTo)
        isCity = 1;
    [textField resignFirstResponder];
}
@end
