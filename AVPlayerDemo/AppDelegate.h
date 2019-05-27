//
//  AppDelegate.h
//  AVPlayerDemo
//
//  Created by NCIT Mobile Desktop on 2019/5/20.
//  Copyright © 2019 NCIT Mobile Desktop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

