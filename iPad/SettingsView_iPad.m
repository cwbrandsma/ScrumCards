    //
//  SettingsView_iPad.m
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "SettingsView_iPad.h"


@implementation SettingsView_iPad
@synthesize nameField;

-(void) save {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:nameField.text forKey:@"name"];
	
}

-(void) load{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *name = [defaults objectForKey:@"name"];
	nameField.text = name;
	
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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iPad-Background-noheader.png"]];
    
	//self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"iPad-Background.png"]];
	[self load];
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
	[nameField release];
	
    [super dealloc];
}

-(IBAction) findServerClick{
	
}

-(IBAction) returnClick {
	[self save];
	
	
	[self dismissModalViewControllerAnimated:YES];
}


@end
