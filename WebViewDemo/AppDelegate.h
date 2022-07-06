//
//  AppDelegate.h
//  WebViewDemo
//
//  Created by wittyx on 7/5/22.
//

#import <Cocoa/Cocoa.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (readonly, strong) NSPersistentCloudKitContainer *persistentContainer;


@end

