//
//  ScrumClient.m
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "ScrumClient.h"
#import <GameKit/GameKit.h>

@implementation ScrumClient

NSString * const ResetCardNotification = @"CardReset";


-(void) displayMessage: (NSString *) title: (NSString *) message {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}

-(id) init {
    self = [super init];
    if (self) {
		asession = nil;
    }
    return self;
	
}
-(void) dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:@"CardSelected" object:nil];
	[asession disconnectFromAllPeers];
	[asession release]; asession = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark Peer Picker
-(void) findPeer {
	peerPicker = [[GKPeerPickerController alloc] init];
	peerPicker.delegate = self;
	
	[peerPicker show];
}

- (void)peerPickerController:(GKPeerPickerController *)picker didSelectConnectionType:(GKPeerPickerConnectionType)type {
	
}

/* Notifies delegate that the connection type is requesting a GKSession object.
 
 You should return a valid GKSession object for use by the picker. If this method is not implemented or returns 'nil', a default GKSession is created on the delegate's behalf.
 */
- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type {
/*
	asession = [[GKSession alloc] initWithSessionID:@"diamondBScrum" 
										displayName:myname 
										sessionMode:GKSessionModeClient];
	
//	asession.delegate = self;
 */
	return asession;
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session{
//	asession = session;
//	asession.delegate = self;
	NSString *serverName = [session displayNameForPeer:peerID];
	NSLog(@"didConnectPeer: %@", serverName);
    
    // Remove the picker.
    picker.delegate = nil;
    [picker dismiss];
    [picker autorelease];

    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConnectedToServer" object:nil];
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker {
	
}


#pragma mark -
-(void) connectToServer : (NSString *) name{
	myname = name;

	if (asession != nil) {
		[asession disconnectFromAllPeers];
		[asession release];
		asession = nil;
	}
	
	asession = [[GKSession alloc] initWithSessionID:@"diamondBScrum" 
									   displayName:name 
									   sessionMode:GKSessionModePeer];
	
	asession.delegate = self;
//	asession.available = YES;
    [asession setDataReceiveHandler:self withContext:nil];

	[self findPeer];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(SendValue:) 
												 name:@"CardSelection" object:nil];
}

-(void) SendValue: (NSNotification *) notification {
	NSString *value = (NSString*)notification.object;
	NSData* data=[value dataUsingEncoding:NSUTF8StringEncoding];
	
	NSError *error = nil;
	[asession sendDataToAllPeers:data withDataMode:GKSendDataReliable error:&error];
}

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state{
	NSString *serverName = [session displayNameForPeer:peerID];
    NSLog(@"Found Server: %@", serverName);
    if (state == GKPeerStateAvailable) {
        //[self displayMessage: @"Server Found": [NSString stringWithFormat:@"%@", serverName]];
        //[session connectToPeer:peerID withTimeout:600];
    }
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID{
	NSLog(@"Connection Request: %@", peerID);
	//[self displayMessage: @"didReceiveConnectionRequestFromPeer": [NSString stringWithFormat:@"%@", peerID]];
	[session denyConnectionFromPeer:peerID];
}

- (void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error {
	[self displayMessage: @"Connection Failed": [error localizedDescription]];
    
}

- (void)session:(GKSession *)session didFailWithError:(NSError *)error{
	[self displayMessage: @"Failed": [error localizedDescription]];	
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context {
    //	NSString *peerName = [session displayNameForPeer:peer];
	NSString *content = [NSString stringWithUTF8String:[data bytes]];
    
    NSLog(@"Data from Peer: %@, %@", peer, content);
    if ([content isEqualToString:@"Reset"]) {
        NSLog(@"Reset the card");
        [[NSNotificationCenter defaultCenter] postNotificationName:ResetCardNotification object:nil userInfo:nil];
    }
}



@end
