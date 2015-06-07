//
//  ServerCards.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/9/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconView.h"


@interface ServerCards : IconView {
    NSMutableArray *carList;
    BOOL frontsVisible;
}

@property (nonatomic, retain) IBOutlet UILabel *bigNumber;

-(void) addPeer: (NSString *) peerId: (NSString *) name;
-(void) peerChanged: (NSString *) peerId: (NSString *) newValue;
-(void) removePeer: (NSString *) peerId;

-(void) showCardFronts;
-(void) showCardBacks;

@end
