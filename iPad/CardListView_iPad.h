//
//  CardListView_iPad.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconView.h"
#import "ScrumClient.h"
#import <iAd/iAd.h>


@interface CardListView_iPad : UIViewController<ADBannerViewDelegate> {
    ScrumClient *client;
    ADBannerView *bannerView;

}

@property (nonatomic, retain) ScrumClient *client;
@property (nonatomic, retain) IBOutlet ADBannerView *bannerView;


-(IBAction) cardClick: (id) sender;
-(IBAction) settingsClick;

@end
