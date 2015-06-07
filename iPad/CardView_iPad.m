    //
//  CardView_iPad.m
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "CardView_iPad.h"


@implementation CardView_iPad
@synthesize cardValue, numberLabel, topNumberLabel, bottomNumberLabel, bannerView;

-(void) sendNumber: (NSString*) text {
	[[NSNotificationCenter defaultCenter] postNotificationName:@"CardSelection" object:text];
	
}

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
extern NSString *ResetCardNotification;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@""];
	//[self styleCard];
	self.numberLabel.titleLabel.adjustsFontSizeToFitWidth = NO;
	self.numberLabel.titleLabel.contentStretch = self.numberLabel.frame;
	self.numberLabel.titleLabel.textAlignment = UITextAlignmentCenter;
	self.numberLabel.titleLabel.frame = self.numberLabel.frame;
	[self.numberLabel setTitle:cardValue forState:UIControlStateNormal];
	[self.topNumberLabel setTitle:cardValue forState:UIControlStateNormal];
	[self.bottomNumberLabel setTitle:cardValue forState:UIControlStateNormal];
	
    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(CardResetHandler:) 
												 name:ResetCardNotification object:nil];

    
	[self sendNumber: cardValue];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


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
	[numberLabel release];
	[cardValue release];
	
    [super dealloc];
}


-(void) CardResetHandler: (NSNotification *) notification {
    [self.navigationController popViewControllerAnimated:YES];
}


-(IBAction) returnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark iAd
// This method is invoked each time a banner loads a new advertisement. Once a banner has loaded an ad, 
// it will display that ad until another ad is available. The delegate might implement this method if 
// it wished to defer placing the banner in a view hierarchy until the banner has content to display.
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    
}

// This method will be invoked when an error has occurred attempting to get advertisement content. 
// The ADError enum lists the possible error codes.
- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    
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
