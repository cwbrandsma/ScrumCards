//
//  CardView_iPad.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>


@interface CardView_iPad : UIViewController<ADBannerViewDelegate> {
	UIButton *numberLabel;
	UIButton *topNumberLabel;
	UIButton *bottomNumberLabel;
	NSString *cardValue;
    ADBannerView *bannerView;
}

@property (nonatomic, retain) IBOutlet UIButton *numberLabel;
@property (nonatomic, retain) IBOutlet UIButton *topNumberLabel;
@property (nonatomic, retain) IBOutlet UIButton *bottomNumberLabel;
@property (nonatomic, retain) IBOutlet ADBannerView *bannerView;
@property (nonatomic, retain) NSString *cardValue;

-(IBAction) returnClick;

@end
