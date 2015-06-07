//
//  AppDelegate_iPad.m
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "AppDelegate_iPad.h"
#import "FlurryAPI.h"
#import <QuartzCore/QuartzCore.h>

@implementation AppDelegate_iPad

@synthesize window, navController;



void uncaughtExceptionHandlerIpad(NSException *exception) {
    [FlurryAPI logError:@"Uncaught" message:@"Crash!" exception:exception];
}


-(void) setupBackground {
    CALayer *parentlayer = navController.view.layer;
    
    CALayer *layer = [CALayer layer];
    layer.contents = (id) [UIImage imageNamed:@"iPad-Background-noheader.png"].CGImage;
    layer.anchorPoint = CGPointMake(parentlayer.position.x, parentlayer.contentsCenter.origin.y);

    [parentlayer addSublayer:layer];
    [layer setNeedsDisplay];
}


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandlerIpad);
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    [FlurryAPI startSession:@"RF72QMTQ2KPG3EZF4N31"];
    
    [self.window addSubview:navController.view];
    [self setupBackground];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
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
    [window release];
    [super dealloc];
}



@end

@implementation UINavigationBar (CustomImage)
- (void)drawRect:(CGRect)rect {
	UIImage *image = [UIImage imageNamed: @"NavBar-background.png"];
	[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end
