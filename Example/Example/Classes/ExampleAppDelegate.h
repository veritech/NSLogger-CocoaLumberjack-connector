//
//  ExampleAppDelegate.h
//  Example
//
//  Created by Peter Steinberger on 26.11.10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExampleViewController;

@interface ExampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ExampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ExampleViewController *viewController;

@end

