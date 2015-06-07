//
//  CardListView_IPhone.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrumClient.h"
#import <iAd/iAd.h>

@interface CardListView_IPhone : UIViewController<ADBannerViewDelegate>{
	ScrumClient *client;
    UIButton *settingsButton;
    ADBannerView *bannerView;
    BOOL bannerIsVisible;
}

@property (nonatomic, retain) IBOutlet UIButton *settingsButton;
@property (nonatomic, retain) IBOutlet ADBannerView *bannerView;

-(IBAction) cardClick: (id) sender;
-(IBAction) settingsClick;
@end
