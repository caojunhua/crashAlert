//
//  AppDelegate.h
//  testAlert
//
//  Created by 曹均华 on 2017/12/19.
//  Copyright © 2017年 caojunhua. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

