//
//  CardController.m
//  BookHot
//
//  Created by Admin on 27.05.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "CardController.h"
#import "AppDelegate.h"
@interface CardController (){
    AppDelegate *app;
    Hotel *hotel;
}
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *descr;
@property (strong, nonatomic) IBOutlet UILabel *country;

@end

@implementation CardController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    hotel = [app getHotelToShow];
    if(hotel != nil) {
        [self showBookInfo];
    }}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showBookInfo {
      [_name setText:hotel.name];
    [_price setText:[NSString stringWithFormat:@"%@",hotel.price]];
    [_descr setText:hotel.description];
    [_country setText:hotel.place];
}

@end
