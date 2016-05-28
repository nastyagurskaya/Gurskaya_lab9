//
//  AppDelegate.m
//  BookHot
//
//  Created by Admin on 27.05.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "SignIn.h"
#import "Trip.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //if (![[NSUserDefaults standardUserDefaults]
        //boolForKey:@"HasLaunchedOnce"]) {
    //[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[NSUserDefaults standardUserDefaults] synchronize];
        SignIn * nastya = [NSEntityDescription insertNewObjectForEntityForName:@"SignIn"
                                                            inManagedObjectContext:self.managedObjectContext];
        nastya.login = @"nastya";
        nastya.password = @"123456";
        SignIn * julia = [NSEntityDescription insertNewObjectForEntityForName:@"SignIn"
                                                        inManagedObjectContext:self.managedObjectContext];
        julia.login = @"julia";
        julia.password = @"123123";
        SignIn * mary = [NSEntityDescription insertNewObjectForEntityForName:@"SignIn"
                                                        inManagedObjectContext:self.managedObjectContext];
        mary.login = @"mary";
        mary.password = @"456456";
    Trip* one = [[Trip alloc]init];
    
    [one setTransport:@"train"];
    [one setCompany:@"Belarusian Railway"];
    [one setCityFrom:@"Minsk"];
    [one setCityTo:@"Vilnius"];
    [one setPrice : [NSNumber
                 numberWithInt:400.0]];
    Trip* two = [[Trip alloc]init];
    [two setTransport:@"plane"];
    [two setCompany:@"FlyLAL"];
    [two setCityFrom:@"Minsk"];
    [two setCityTo:@"Vilnius"];
    [two setPrice : [NSNumber
                     numberWithInt:600.0]];

    Trip* three = [[Trip alloc]init];
    [three setTransport:@"bus"];
    [three setCompany:@"Ecolines"];
    [three setCityFrom:@"Minsk"];
    [three setCityTo:@"Vilnius"];
    [three setPrice : [NSNumber
                     numberWithInt:300.0]];
    Trip* four = [[Trip alloc]init];
    [four setTransport:@"bus"];
    [four setCompany:@"Ecolines"];
    [four setCityFrom:@"Minsk"];
    [four setCityTo:@"Kiev"];
    [four setPrice : [NSNumber
                       numberWithInt:350.0]];
    Trip* five = [[Trip alloc]init];
    [five setTransport:@"plan"];
    [five setCompany:@"Belavia"];
    [five setCityFrom:@"Minsk"];
    [five setCityTo:@"Kiev"];
    [five setPrice : [NSNumber
                      numberWithInt:900.0]];

    Trip* six = [[Trip alloc]init];
    [six setTransport:@"train"];
    [six setCompany:@"Lituva Railway"];
    [six setCityFrom:@"Vilnius"];
    [six setCityTo:@"Minsk"];
    [six setPrice : [NSNumber
                      numberWithInt:900.0]];
      //}
    _trips=[NSArray arrayWithObjects:one,two,three,four,five,six, nil];
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "myorg.BookHot" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"BookHot" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"BookHot.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
- (NSArray *)getPasswordWithLogin:(NSString *)login
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"login == %@", login]];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"SignIn" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError* error;
    NSArray *fetchedRecords = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    return fetchedRecords;
}
- (NSMutableArray *)getFlightsWithCityFrom:(NSString *)cityFrom andCityTo:(NSString *)cityTo
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:6];
    for (Trip * kk in _trips) {
        if ([kk.cityTo isEqualToString: cityTo]&&[kk.cityFrom isEqualToString: cityFrom]) {
           [array addObject:kk];
        }
    }
   // [array addObject:nil];
    return array;
}
@end
