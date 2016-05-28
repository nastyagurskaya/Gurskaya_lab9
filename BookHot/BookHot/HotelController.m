//
//  HotelController.m
//  BookHot
//
//  Created by Admin on 27.05.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "HotelController.h"
#import "AppDelegate.h"
#import "Hotel.h"
@interface HotelController (){
    AppDelegate *app;
    NSMutableArray *resultHotels;
}

@property (strong, nonatomic) IBOutlet UITableView *listOfHotels;

@end

@implementation HotelController

- (void)viewDidLoad {
    [super viewDidLoad];
    resultHotels = nil;
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    resultHotels = [app getHotels];
    if([resultHotels count] > 0) {
        [_listOfHotels reloadData];
    }
    else {
        [_listOfHotels reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(resultHotels == nil) {
        return 0;
    }
    return [resultHotels count];
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
    Hotel *rec = (Hotel *)[resultHotels objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ | %@",rec.name,rec.place];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath) {
        [app setSelectedHotel:resultHotels[indexPath.row]];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
@end
