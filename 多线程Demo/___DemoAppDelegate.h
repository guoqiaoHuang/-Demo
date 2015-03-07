//
//  ___DemoAppDelegate.h
//  多线程Demo
//
//  Created by wangshuai on 14-1-8.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ___DemoAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
