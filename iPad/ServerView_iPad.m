    //
//  ServerView_iPad.m
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "ServerView_iPad.h"
#import <GameKit/GameKit.h>
#import "ServerCardValue.h"

@interface ServerView_iPad(NSObject) 
-(void) toggleCards;
-(void) showCardBack;
-(void) showCardValue;
@end

@implementation ServerView_iPad

@synthesize serverNameEdit, cardView, serverName,
    showCardsView, flipCardsView, minValue, maxValue, medianValue,
    externalWindow;

/*
 //need a VGA connector to test this code.
-(void) updateExternalWindow {
    if ([[UIScreen screens] count] >1) {
        // external screen is connected
        UIScreen * externalScreen = [[UIScreen screens] lastObject];
        UIScreenMode *highestScreenMode = [[externalScreen availableModes] lastObject];
        CGRect externalWindowFrame = CGRectMake(0, 0, [highestScreenMode size].width, highestScreenMode.size.width);
        self.externalWindow = [[[UIWindow alloc] initWithFrame:externalWindowFrame] autorelease];
        externalWindow.screen = externalScreen;
        [externalWindow.screen setCurrentMode:highestScreenMode];
        [externalWindow makeKeyAndVisible];
        [externalWindow addSubview:cardView];
        
    } else {
        // no screens are connected
        self.externalWindow.screen = nil;
        self.externalWindow = nil;
    }
    
}
 */


-(void) displayMessage: (NSString *) title: (NSString *) message {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title 
                                                    message:message 
                                                   delegate:self 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
	[alert show];
	[alert release];
}

-(void) toggleCards {    
    if (cardFaceUp) {
        [self showCardBack];
    } else{
        [self showCardValue];
    }
    
    cardFaceUp = !cardFaceUp;

}
-(void) createServer {
	if (aSession != nil) {
		[aSession disconnectFromAllPeers];
		[aSession release];
		aSession = nil;
	}
	
	aSession = [[GKSession alloc] initWithSessionID:@"diamondBScrum" 
										displayName:serverName 
										sessionMode:GKSessionModeServer];
	
	aSession.delegate = self;
	aSession.available = YES;
	[aSession setDataReceiveHandler:self withContext:nil];
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

-(void) setupNavigationBar {
//    UIBarButtonItem *flipButton = [[UIBarButtonItem alloc] initWithTitle:@"Flip Cards" style:UIBarButtonSystemItemAction target:self action:@selector(flipCardsClick:)];
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                         target:self action:@selector(flipCardsClick:)];
    
    [self.navigationItem setRightBarButtonItem:btn animated:YES];
    [btn release];

}

-(void) resetView {
    [self.cardView clearView];
}

- (void)handleTap:(UITapGestureRecognizer *)sender {     
    if (sender.state == UIGestureRecognizerStateEnded) {         
        [self toggleCards];    
    } 
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Estimation Board"];
    [self setupNavigationBar];
    cardFaceUp = false;

    [self createServer];
    [self.cardView clearView];
    
    self.showCardsView.hidden = NO;
    self.flipCardsView.hidden = YES;
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self.view addGestureRecognizer:tapGesture];
    
    //setup external monitor support
    /*
    [self updateExternalWindow];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateExternalWindow) 
                                                 name:UIScreenDidConnectNotification
                                               object:nil];
    */
    
    /* 
    //TODO: Card for testing
    [self.cardView addPeer:@"Test1" :@"Test1"];
    [self.cardView addPeer:@"Test2" :@"Test2"];
    [self.cardView addPeer:@"Test3" :@"Test3"];
    [self.cardView addPeer:@"Test4" :@"Test4"];
    [self.cardView addPeer:@"Test5" :@"Test5"];
    [self.cardView addPeer:@"Test6" :@"Test6"];
    [self.cardView addPeer:@"Test7" :@"Test7"];
    [self.cardView addPeer:@"Test8" :@"Test8"];
    [self.cardView addPeer:@"Test9" :@"Test9"];
   */
}

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state{
	if (state == GKPeerStateDisconnected) {
        [self.cardView removePeer:peerID];
    }
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID {
	NSString *peerName = [session displayNameForPeer:peerID];
	
	NSError *error;
	
	NSLog(@"Peer connection request: %@", peerName);
	if (![session acceptConnectionFromPeer:peerID error:&error]) {
			// handle error
		NSLog(@"Peer Connection Error: %@, %@", peerName, [error localizedDescription]);
	} 
	
    [self.cardView addPeer:peerID :peerName];
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error{
	[self displayMessage:@"Client Connection Failed": [NSString stringWithFormat:@"Peer connection failed: %@", peerID]];
    [cardView removePeer:peerID];
	
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error{
	[self displayMessage:@"Session Failed": [NSString stringWithFormat:@"Session Failed: %@", [error localizedDescription]]];
    [cardView clearView];
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context {
//	NSString *peerName = [session displayNameForPeer:peer];
	NSString *content = [NSString stringWithUTF8String:[data bytes]];

    NSLog(@"Data from Peer: %@, %@", peer, content);
    [self.cardView peerChanged:peer :content];    
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
    self.showCardsView = nil;
    self.flipCardsView = nil;
}


- (void)dealloc {
//	[self save];
    self.externalWindow = nil;
    [cardView clearView];
	[aSession disconnectFromAllPeers];
    [showCardsView release];
    [flipCardsView release];
    [minValue release];
    [maxValue release];
    [medianValue release];
    
    
	[serverNameEdit release];
	[cardView release];
	[aSession release];
    [tapGesture release];
    
    [super dealloc];
}

-(IBAction) createServerClick {
    [self createServer];
}


-(void) showCardValue {
    [self.cardView showCardFronts];
    
    self.showCardsView.hidden = YES;
    self.flipCardsView.hidden = NO;
}

-(void) showCardBack{
    [self.cardView showCardBacks];
    self.showCardsView.hidden = NO;
    self.flipCardsView.hidden = YES;
    
    
    // send message to devices to reset
    NSString *value = @"Reset";
	NSData* data=[value dataUsingEncoding:NSUTF8StringEncoding];
	NSError *error = nil;
	[aSession sendDataToAllPeers:data withDataMode:GKSendDataUnreliable error:&error];    
}



-(IBAction) flipCardsClick: (id) sender {
    [self toggleCards];
}



-(IBAction) resetCardsClick {
}


@end
