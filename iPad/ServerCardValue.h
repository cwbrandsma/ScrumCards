//
//  ServerCardValue.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/9/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ServerCardValue : NSObject {
	NSString *peerName;
    NSString *peerId;
	NSString *cardValue;
}

@property (nonatomic, retain) NSString *peerName;
@property (nonatomic, retain) NSString *cardValue;
@property (nonatomic, retain) NSString *peerId;

@end
