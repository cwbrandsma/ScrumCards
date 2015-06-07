//
//  ScrumCard.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/9/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ScrumCard : UIViewController {
	UILabel *nameLabel;
	UILabel *cardValueLabel;
    UILabel *cardTopLabel;
    UILabel *cardBottomLabel;
    NSString *peerId;
    UIView *cardView;
    UIImageView *cardBack;
    UIView *cardContainer;
	
    NSString *peerName;
    BOOL frontViewIsVisible;
    BOOL highlightCard;
}

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *cardValueLabel;
@property (nonatomic, retain) IBOutlet UILabel *cardTopLabel;
@property (nonatomic, retain) IBOutlet UILabel *cardBottomLabel;
@property (nonatomic, retain) IBOutlet UIView *cardView;
@property (nonatomic, retain) IBOutlet UIView *cardContainer;
@property (nonatomic, retain) IBOutlet UIImageView *cardBack;
@property (nonatomic, retain) NSString *peerId;

-(void) initCard: (NSString *) peerId: (NSString *) name;

-(void) showCardBack;
-(void) showCardFront;
-(void) showSelectionMade;

-(void) addCardHighlight;
-(void) removeCardHighlight;


@end
