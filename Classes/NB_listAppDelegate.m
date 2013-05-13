//
//  NB_listAppDelegate.m
//  NB_list
//
//  Created by mac on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NB_listAppDelegate.h"
#import "RootViewController.h"
#import "Parse/Parse.h"


@implementation NB_listAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize correct;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   // self.window.rootViewController = self.viewController;
   // [self.window makeKeyAndVisible];
    
    [Parse setApplicationId:@"FqskKgV1VaIRPvfwFrb2lTujy55JmLODR4j9z4PL" clientKey:@"nFdXFAo29NTfmvnWB64CUCCkA5maF1eEZRHQjiHK"];
    
    // Override point for customization after application launch.
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound];

    
    
    // Override point for customization after application launch.
    
    // Set the navigation controller as the window's root view controller and display.
    //theScore = [[NSInteger alloc] init];
	[self.window addSubview:[navigationController view]];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSLog(@"My token is: %@", deviceToken);
    [PFPush storeDeviceToken:deviceToken];
    [PFPush subscribeToChannelInBackground:@"" block:^(BOOL succeeded, NSError *error) {
        if (succeeded)
            NSLog(@"Successfully subscribed to broadcast channel!");
        else
            NSLog(@"Failed to subscribe to broadcast channel; Error: %@",error);
    }];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
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
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
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
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

