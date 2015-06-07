//
//  ScrumCard.m
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/9/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "ScrumCard.h"
#import "ServerCardValue.h"
#import <QuartzCore/QuartzCore.h>

extern NSString *showCardValueNotification;
extern NSString *CardValueSentNotification;
extern NSString *showCardBackNotification;

@implementation ScrumCard
@synthesize cardValueLabel, nameLabel, peerId,
cardBottomLabel, cardTopLabel, cardBack, cardContainer, cardView;

-(void) initNotificationObservers{
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(CardValueSentHandler:) 
												 name:CardValueSentNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(ShowCardValueHandler:) 
												 name:showCardValueNotification object:nil]; 

    [[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(ShowCardBackHandler:) 
												 name:showCardBackNotification object:nil]; 

}



-(void) initCard: (NSString *) apeerId: (NSString *) name {
    peerName = name;
    self.peerId = apeerId;
}

-(void) setCardValue: (NSString *) value {
    cardValueLabel.text = value;
    cardTopLabel.text = value;
    cardBottomLabel.text = value;
}

-(void) initDisplayControls {
/*
	CGRect *nameRect = CGRectMake(0., 0., 200., 50.);
	nameLabel = [[UILabel alloc] initWithFrame:nameRect];
    [self addSubview:nameLabel];
	
	CGRect *cardRect = CGRectMake(55, 0, 200, 150);
	cardValueLabel = [[UILabel alloc] initWithFrame:cardRect];
 */
}

-(void) initFrame {
    // give the card its shape
    CALayer *layer = self.cardContainer.layer;
    
	layer.borderWidth = 1;
	layer.borderColor = [[UIColor grayColor] CGColor];
	layer.cornerRadius = 10;
    layer.masksToBounds = YES;
}

-(void) viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self initFrame];
    [self initNotificationObservers];
    
    frontViewIsVisible = NO;
    
    self.nameLabel.text = peerName;
    [self setCardValue:@"?"];
}


/*
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		//[self initDisplayControls];
		[self initFrame];
		[self initNotificationObservers];
		
    }
    return self;
} */

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
    [nameLabel release];
    [cardValueLabel release];
    [cardTopLabel release];
    [cardBottomLabel release];
    [cardView release];
    [cardContainer release];
    [cardBack release];
    
    [super dealloc];
}

-(void) addCardHighlight {
    cardBack.highlighted = YES;
    highlightCard = YES;
/*
    CALayer *layer = self.view.layer;
    layer.masksToBounds = NO;
    layer.cornerRadius = 8; // if you like rounded corners
    layer.shadowOffset = CGSizeMake(-10, 10);
    layer.shadowColor = [[UIColor whiteColor] CGColor];
    layer.shadowRadius = 5;
    layer.shadowOpacity = 0.5;    
 */
}
-(void) removeCardHighlight {
    cardBack.highlighted = NO;
    highlightCard = NO;
    /*
    CALayer *layer = self.view.layer;
    layer.shadowColor = [[UIColor clearColor] CGColor];
     */
}
 

-(void) CardValueSentHandler: (NSNotification *) notification {
    NSDictionary *dict = [notification userInfo];
    NSString *notePeer = [dict objectForKey:@"peerId"];
    NSString *value = [dict objectForKey:@"value"];
    
	if ([peerId isEqualToString: notePeer]) {
		cardValueLabel.text = value;
        cardTopLabel.text = value;
        cardBottomLabel.text = value;

        if (!frontViewIsVisible) {
            [self addCardHighlight];
        }
	}
    
}


- (void)flipCurrentView {
	// setup the animation group
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(myTransitionDidStop:finished:context:)];
	
	// swap the views and transition
    if (frontViewIsVisible==YES) {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:cardContainer cache:YES];
        self.cardBack.hidden = NO;
        self.cardView.hidden = YES;
    } else {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cardContainer cache:YES];
        self.cardBack.hidden = YES;
        self.cardView.hidden = NO;
    }
	[UIView commitAnimations];
	/*	
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(myTransitionDidStop:finished:context:)];
    
    
	[UIView commitAnimations];
     */
	frontViewIsVisible=!frontViewIsVisible;
}


- (void)myTransitionDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
}

-(void) showCardBack {
    if (frontViewIsVisible) {
        [self flipCurrentView];
    }
    [self setCardValue:@"-"];
}

-(void) showCardFront{
    if (!frontViewIsVisible) {
        [self flipCurrentView];
    }    
}

-(void) showSelectionMade{
    
}

-(void) ShowCardValueHandler: (NSNotification *) notification {
    [self showCardFront];
    [self removeCardHighlight];
}

-(void) ShowCardBackHandler: (NSNotification *) notification {
    [self showCardBack];
    [self removeCardHighlight];
}

@end
