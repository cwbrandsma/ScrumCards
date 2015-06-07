//
//  CardView_iPhone.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>


@interface CardView_iPhone : UIViewController<ADBannerViewDelegate> {
	UIButton *numberLabel;
	NSString *cardValue;
    UILabel *topNumber;
    UILabel *bottomNumber;
    ADBannerView *bannerView;
    BOOL bannerIsVisible;
}

@property (nonatomic, retain) IBOutlet UIButton *numberLabel;
@property (nonatomic, retain) IBOutlet UILabel *topNumber;
@property (nonatomic, retain) IBOutlet UILabel *bottomNumber;
@property (nonatomic, retain) NSString *cardValue;
@property (nonatomic, retain) IBOutlet ADBannerView *bannerView;


-(IBAction) returnClick;
@end
