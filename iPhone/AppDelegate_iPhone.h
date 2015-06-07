//
//  AppDelegate_iPhone.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InAppPurchaseManager.h"

@interface AppDelegate_iPhone : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController *navController;
    InAppPurchaseManager *purchaseManager;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;
@property (nonatomic, retain) InAppPurchaseManager *purchaseManager;

@end

