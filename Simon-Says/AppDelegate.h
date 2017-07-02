//
//  AppDelegate.h
//  Simon-Says
//
//  Created by Matthew Allen Lin on 7/2/17.
//  Copyright © 2017 Matthew Allen Lin Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

