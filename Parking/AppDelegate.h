//
//  AppDelegate.h
//  Parking
//
//  Created by 蔡維昌 on 2019/7/15.
//  Copyright © 2019 蔡維昌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

