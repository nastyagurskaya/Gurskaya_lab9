//
//  AppDelegate.h
//  BookHot
//
//  Created by Admin on 27.05.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Hotel.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nullable) NSArray *trips;
@property (nullable) NSArray *hotels;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (NSArray *)getPasswordWithLogin:(NSString *)Login;
- (NSMutableArray *)getFlightsWithCityFrom:(NSString *)cityFrom andCityTo:(NSString *)cityTo;
- (NSMutableArray *)getHotels;
- (void)setSelectedHotel:(Hotel *)book;
- (Hotel *)getHotelToShow;
@end

