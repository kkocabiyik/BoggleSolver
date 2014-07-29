//
//  WHAppDelegate.h
//  WordsHelper
//
//  Created by Kemal Kocabiyik on 10/27/13.
//  Copyright (c) 2013 Ovidos Creative. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WHSolverViewController.h"
@interface WHAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) WHSolverViewController *solverViewController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
