//
//  ScrumClient.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface ScrumClient : NSObject<GKSessionDelegate, GKPeerPickerControllerDelegate> {
	GKSession *asession;
	GKPeerPickerController *peerPicker;
	NSString *myname;
}



-(void) connectToServer: (NSString *) name;

@end
