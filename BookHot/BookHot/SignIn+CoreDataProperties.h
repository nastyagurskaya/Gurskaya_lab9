//
//  SignIn+CoreDataProperties.h
//  BookHot
//
//  Created by Admin on 28.05.16.
//  Copyright © 2016 Admin. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SignIn.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignIn (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *login;
@property (nullable, nonatomic, retain) NSString *password;

@end

NS_ASSUME_NONNULL_END
