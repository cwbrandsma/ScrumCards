//
//  CardListView_IPhone.m
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CardListView_IPhone.h"
#import <QuartzCore/QuartzCore.h>
#import "CardView_iPhone.h"
#import "SettingsView_IPhone.h"
#import "ScrumClient.h"
#import "InAppPurchaseManager.h"

@implementation CardListView_IPhone
@synthesize settingsButton, bannerView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] < 4.2)
    {
        bannerView.requiredContentSizeIdentifiers = [NSSet setWithObject:ADBannerContentSizeIdentifier320x50];
        bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifier320x50;
    }
    
    
    [super viewDidLoad];

	client = [[ScrumClient alloc] init];
    
    //self.bannerView.requiredContentSizeIdentifiers = [NSSet setWithObjects: ADBannerContentSizeIdentifierPortrait, nil];
    bannerView.hidden = ![InAppPurchaseManager showAds];

}

-(void) viewDidAppear:(BOOL)animated {
    settingsButton.hidden = NO;
    bannerView.hidden = ![InAppPurchaseManager showAds];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [bannerView release];
    [settingsButton release];
	[client release];
    [super dealloc];
}

-(IBAction) cardClick: (id) sender{
    // hide the settings button because we don't like how it looks during a transition
    settingsButton.hidden = YES;

	UIButton *b = (UIButton *)sender;
	NSString *value =b.titleLabel.text; 
	
    // create the view
	CardView_iPhone *view = [[CardView_iPhone alloc] initWithNibName:nil bundle:nil];
	view.cardValue = value;
	
    // present and animation the tranition
	view.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//	[self.navigationController presentModalViewController:view animated:YES];
	[self presentModalViewController:view animated:YES];
	
	[view release];
}

-(IBAction) settingsClick {
    // hide the settings button because we don't like how it looks during a transition
    settingsButton.hidden = YES;
    
    // create the view
	SettingsView_IPhone	*viewController = [[SettingsView_IPhone alloc] initWithNibName:nil bundle:nil];
	viewController.client = client;
    
    // present and animation the tranition
    viewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.navigationController presentModalViewController:viewController animated:YES];
    
    // release the view controller
    [viewController release];
}

#pragma mark -
#pragma mark iAd
// This method is invoked each time a banner loads a new advertisement. Once a banner has loaded an ad, 
// it will display that ad until another ad is available. The delegate might implement this method if 
// it wished to defer placing the banner in a view hierarchy until the banner has content to display.
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (!bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        [UIView commitAnimations];
        bannerIsVisible = YES;
    }
}

// This method will be invoked when an error has occurred attempting to get advertisement content. 
// The ADError enum lists the possible error codes.
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    if (bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        [UIView commitAnimations];
        bannerIsVisible = NO;
    }
}

// This message will be sent when the user taps on the banner and some action is to be taken.
// Actions either display full screen content in a modal session or take the user to a different
// application. The delegate may return NO to block the action from taking place, but this
// should be avoided if possible because most advertisements pay significantly more when 
// the action takes place and, over the longer term, repeatedly blocking actions will 
// decrease the ad inventory available to the application. Applications may wish to pause video, 
// audio, or other animated content while the advertisement's action executes.
- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave {
    return YES;
}

// This message is sent when a modal action has completed and control is returned to the application. 
// Games, media playback, and other activities that were paused in response to the beginning
// of the action should resume at this point.
- (void)bannerViewActionDidFinish:(ADBannerView *)banner {
    
}

@end
