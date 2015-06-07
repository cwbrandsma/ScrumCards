    //
//  ModeSelectView_iPad.m
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "ModeSelectView_iPad.h"
#import "ServerView_iPad.h"
#import "CardListView_iPad.h"
#import "ScrumClient.h"

@implementation ModeSelectView_iPad

@synthesize serverTab, clientTab, clientName, serverName, serverTabButton, clientTabButton;

-(void) save {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:serverName.text forKey:@"serverName"];
    [defaults setObject:clientName.text forKey:@"clientName"];
	
}

-(void) load{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    UIDevice *device = [[UIDevice alloc] init];
	
//	serverName.text = [defaults objectForKey:@"serverName"];
//    clientName.text = [defaults objectForKey:@"clientName"];
    
    NSString *name = [defaults objectForKey:@"clientName"];
    if ([name length] > 0) {
        clientName.text = name;
    } else {
        clientName.text = device.name;
    }
    
    name = [defaults objectForKey:@"serverName"];
    if ([name length] > 0) {
        serverName.text = name;
    } else {
        serverName.text = device.name;
    }

    [device release];
    
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

-(void) updateBackgroundImage: (UIInterfaceOrientation)toInterfaceOrientation {
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Agile Cards"];
    clientTab.hidden = YES;
    [self load];
    
    UIDevice *device = [[UIDevice alloc] init];
    [self updateBackgroundImage:device.orientation ];
    [device release];
}

-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self updateBackgroundImage: toInterfaceOrientation];
    
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
    [self save];
    [client release];
    [serverName release];
    [clientName release];
    [serverTab release];
    [clientTab release];
    
    [super dealloc];
}

-(IBAction) createServerClick {
	ServerView_iPad *view = [[ServerView_iPad alloc] initWithNibName:nil bundle:nil];
    view.serverName = serverName.text;
    [view resetView];
	[self.navigationController pushViewController:view animated:YES];
	[view release];
}

-(IBAction) createClientClick {
	CardListView_iPad *view = [[CardListView_iPad alloc] initWithNibName:nil bundle:nil];
    view.client = client;
	[self.navigationController pushViewController:view animated:YES];
	[view release];
}

-(IBAction) serverTabClick{
    clientTab.hidden = YES;
    serverTab.hidden = NO;
    [serverTabButton setBackgroundImage:[UIImage imageNamed:@"buttonLeftPressed.png"] forState:UIControlStateNormal];
    [clientTabButton setBackgroundImage:[UIImage imageNamed:@"buttonRight.png"] forState:UIControlStateNormal];
    
}
-(IBAction) clientTabClick{
    clientTab.hidden = NO;
    serverTab.hidden = YES;
    [serverTabButton setBackgroundImage:[UIImage imageNamed:@"buttonLeft.png"] forState:UIControlStateNormal];
    [clientTabButton setBackgroundImage:[UIImage imageNamed:@"buttonRightPressed.png"] forState:UIControlStateNormal];
}

-(IBAction) connectToServerClick {
    client = [[ScrumClient alloc] init];
    [client connectToServer:clientName.text];
}


@end
