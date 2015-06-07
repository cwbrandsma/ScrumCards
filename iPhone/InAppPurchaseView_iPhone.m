//
//  InAppPurchaseView_iPhone.m
//  ScrumBoard
//
//  Created by Chris Brandsma on 12/3/11.
//  Copyright (c) 2011 DiamondB Software. All rights reserved.
//

#import "InAppPurchaseView_iPhone.h"
#import "InAppPurchaseManager.h"
#import "AppDelegate_iPhone.h"


@implementation InAppPurchaseView_iPhone

@synthesize priceLabel, purchaseButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    purchaseButton.hidden = YES;
    priceLabel.text = @"Retrieving price...";
    // Do any additional setup after loading the view from its nib.
    
    AppDelegate_iPhone *appDelegate = (AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
    manager = appDelegate.purchaseManager;
    manager.delegate = self;
//    [manager loadStore];
    
    products = [[NSArray arrayWithArray: manager.products] retain];
    if (products != nil) {
        purchaseButton.hidden = false;
        for (SKProduct *product in products) {
            priceLabel.text = [NSString stringWithFormat:@"Price: %@",product.localizedPrice];
        }

    }

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    AppDelegate_iPhone *appDelegate = (AppDelegate_iPhone *)[[UIApplication sharedApplication] delegate];
    manager = appDelegate.purchaseManager;
    manager.delegate = nil;

}

-(void) dealloc {
//    [manager release];
    [priceLabel release];
    [purchaseButton release];
    [products release];
    
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)returnClick {
    [self dismissModalViewControllerAnimated:YES]; 
}

-(void) productsAvailableForPurchase: (NSArray *) aproducts {
    purchaseButton.hidden = NO;
    products = [[NSArray arrayWithArray:aproducts] retain];
    for (SKProduct *product in products) {
        priceLabel.text = [NSString stringWithFormat:@"Price: %@",product.localizedPrice];
    }
}

-(IBAction)purchaseProduct {
    [purchaseButton setTitle:@"Purchase in process" forState:UIControlStateNormal];
    [manager purchaseProduct: [products objectAtIndex:0]];
    
}

-(void) productPurchaseFailed {
    UIAlertView* alert = [[UIAlertView alloc] 
                          initWithTitle:@"Purchase Failed" 
                          message:@"Sorry, the purchase failed for some reason.  Please try again later" 
                          delegate:self 
                          cancelButtonTitle:@"OK"
                          otherButtonTitles: nil];
    [alert show];
    [alert release];
    
}
-(void) productWasPurchased: (SKPayment*) payment {
    UIAlertView* alert = [[UIAlertView alloc] 
                          initWithTitle:@"Purchase Compete" 
                          message:@"Purchase Complete.  Thank you" 
                          delegate:self 
                cancelButtonTitle:@"OK"
                          otherButtonTitles: nil];
    [alert show];
    [alert release];
    
    [self dismissModalViewControllerAnimated:YES]; 
    
}

@end
