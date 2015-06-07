//
//  SettingsView_IPhone.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrumClient.h"
#import <MessageUI/MessageUI.h>


@interface SettingsView_IPhone : UIViewController<MFMailComposeViewControllerDelegate> {
	UITextField *nameField;
	ScrumClient *client;
    UIButton *removeAdsButton;
    UIImageView *noAdsBadge;
}

@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) ScrumClient *client;
@property (nonatomic, retain) IBOutlet UIButton *removeAdsButton;
@property (nonatomic, retain) IBOutlet UIImageView *noAdsBadge;

-(IBAction) findServerClick;
-(IBAction) returnClick;
-(IBAction) contactUsClick;
-(IBAction) chrisBrandsmaClick;
-(IBAction) nathanBarryClick;
-(IBAction) removeAdsClick:(id)sender;
@end
