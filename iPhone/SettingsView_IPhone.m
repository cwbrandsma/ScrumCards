//
//  SettingsView_IPhone.m
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "SettingsView_IPhone.h"
#import "ScrumClient.h"
#import "InAppPurchaseManager.h"
#import "InAppPurchaseView_iPhone.h"

@implementation SettingsView_IPhone
@synthesize nameField, client, removeAdsButton, noAdsBadge;

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

-(void) save {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:nameField.text forKey:@"name"];

}

-(void) load{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *name = [defaults objectForKey:@"name"];
    if ([name length] > 0) {
        nameField.text = name;
    } else {
        UIDevice *device = [[UIDevice alloc] init];
        nameField.text = device.name;
        [device release];
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default.png"]];
	[self load];
    
    BOOL purchasedNoAds = ![InAppPurchaseManager showAds];
    removeAdsButton.hidden=purchasedNoAds;
    noAdsBadge.hidden = !purchasedNoAds;

}

-(void) viewDidAppear:(BOOL)animated {
    BOOL purchasedNoAds = ![InAppPurchaseManager showAds];
    removeAdsButton.hidden=purchasedNoAds;
    noAdsBadge.hidden = !purchasedNoAds;
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
	[client release];
	[nameField release];
    [removeAdsButton release];
    [noAdsBadge release];
    
    [super dealloc];
}

-(IBAction) findServerClick{
	[client connectToServer: nameField.text];
}

-(IBAction) returnClick {
	[self save];
	
	
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction) contactUsClick {
	MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
	mc.mailComposeDelegate = self;
	[mc setToRecipients:[NSArray arrayWithObject:@"AgileCards@diamondbsoftware.com"]];
	[mc setSubject:@"AgileCards Support"];
	
	[self presentModalViewController:mc animated:YES];
	[mc release];    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
	/* Notifies users about errors associated with the interface
	 switch (result)
	 {
	 case MFMailComposeResultCancelled:
	 break;
	 case MFMailComposeResultSaved:
	 break;
	 case MFMailComposeResultSent:
	 break;
	 case MFMailComposeResultFailed:
	 break;
	 
	 default:
	 {
	 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending Failed - Unknown Error :-("
	 delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
	 [alert show];
	 [alert release];
	 }
	 
	 break;
	 }*/
	[self dismissModalViewControllerAnimated:YES];
	
}

- (IBAction)gotoReviews:(id)sender {
	NSString *iTunesLink = @"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=395247000&mt=8";
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];	
}

-(IBAction) chrisBrandsmaClick{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://DiamondBSoftware.com"]];
    
}
-(IBAction) nathanBarryClick{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://ThinkLegend.com"]];    
}

-(IBAction) removeAdsClick:(id)sender {
    
    InAppPurchaseView_iPhone *view = [[InAppPurchaseView_iPhone alloc] initWithNibName:nil bundle:nil];
    view.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:view animated:YES];
//    [self.navigationController presentModalViewController:view animated:YES];
    
    // release the view controller
    [view release];


}


@end
