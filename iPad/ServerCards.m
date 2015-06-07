//
//  ServerCards.m
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/9/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "ServerCards.h"
#import "ServerCardValue.h"
#import "ScrumCard.h"

NSString * const CardValueSentNotification = @"CardValueSent";

@implementation ServerCards
@synthesize bigNumber;

-(id) init {
    self = [super init];
    if (self) {
		carList = [[NSMutableArray alloc] init];        
        frontsVisible = NO;
    }
    return self;
    
}

-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        frontsVisible = NO;
		carList = [[NSMutableArray alloc] init];
        // Initialization code.
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        frontsVisible = NO;
		carList = [[NSMutableArray alloc] init];
        // Initialization code.
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [carList release];
    [super dealloc];
}

-(void) addPeer: (NSString *) peerId: (NSString *) name {
    ScrumCard *card = [[ScrumCard alloc] initWithNibName:@"ScrumCard" bundle:[NSBundle mainBundle]];
    [card initCard:peerId :name];

    UIView *myView = card.view;
    [self addTile:myView];
    [carList addObject:card];
    [card release];
}

-(void) removePeer: (NSString *) peerId {
    for (ScrumCard *card in carList) {
        if ([card.peerId isEqualToString:peerId]) {
            [self removeTile:card.view];
            [carList removeObject:card];
        }
    }
}

-(void) clearView {
    [carList removeAllObjects];
    [super clearView];
}


-(void) peerChanged: (NSString *) peerId: (NSString *) newValue{
    NSDictionary *values = [NSDictionary dictionaryWithObjectsAndKeys:peerId, @"peerId", newValue, @"value", nil];

    [[NSNotificationCenter defaultCenter] postNotificationName:CardValueSentNotification object:newValue userInfo:values];
    
    if (frontsVisible) {
        [self showCardFronts];
    }
    NSLog(@"New Peer Value: %@ for peer %@", newValue, peerId);

}
NSString * const showCardValueNotification = @"ShowCardValues";
NSString * const showCardBackNotification = @"ShowCardBacks";


-(void) showCardFronts {
    [[NSNotificationCenter defaultCenter] postNotificationName:showCardValueNotification object:nil];
    frontsVisible = YES;
}

-(void) showCardBacks{
    [[NSNotificationCenter defaultCenter] postNotificationName:showCardBackNotification object:nil];
    frontsVisible = NO;
}


@end
