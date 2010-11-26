//
//  ExampleAppDelegate.m
//  Example
//
//  Created by Peter Steinberger on 26.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ExampleAppDelegate.h"
#import "ExampleViewController.h"
#import "PSDDFormatter.h"
#import "DDFileLogger.h"
#import "DDTTYLogger.h"
#import "DDNSLoggerLogger.h"

@implementation ExampleAppDelegate

@synthesize window;
@synthesize viewController;


- (void)configureLogger {
  PSDDFormatter *psLogger = [[[PSDDFormatter alloc] init] autorelease];
  [[DDTTYLogger sharedInstance] setLogFormatter:psLogger];

  [DDLog addLogger:[DDTTYLogger sharedInstance]];

  DDFileLogger *fileLogger = [[[DDFileLogger alloc] init] autorelease];
  fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
  fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
  [DDLog addLogger:fileLogger];

  // CRASHES WITH DDLogError. dunno why.
  [DDLog addLogger:[DDNSLoggerLogger sharedInstance]];
}

- (NSString *)applicationDocumentsDirectory {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
  return basePath;
}

- (NSURL *)storeUrl {
  return [NSURL fileURLWithPath:[[self applicationDocumentsDirectory]
                                 stringByAppendingPathComponent: @"CoreDataStore.sqlite"]];
}


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [self configureLogger];

  DDLogInfo(@"Hello from the Logger!");


  DDLogInfo(@"and on the next log, i'll totally crash...");
  NSURL *storeURL = [self storeUrl];
  if (storeURL) {
    NSError *err = noErr;
    BOOL removed = [[NSFileManager defaultManager] removeItemAtPath:storeURL.path
                                                              error:&err];
    if (!removed || err) {
      DDLogError(@"could not delete store at URL %@ (%@)", storeURL, [err localizedDescription]);
    }
  }


  [self.window addSubview:viewController.view];
  [self.window makeKeyAndVisible];

  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
   If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
   */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  /*
   Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
   */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {
  /*
   Called when the application is about to terminate.
   See also applicationDidEnterBackground:.
   */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
  /*
   Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
   */
}


- (void)dealloc {
  [viewController release];
  [window release];
  [super dealloc];
}


@end
