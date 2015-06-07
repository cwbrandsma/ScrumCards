//
//  ServerView_iPad.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "ServerCards.h"

@interface ServerView_iPad : UIViewController <GKSessionDelegate, UIActionSheetDelegate>{
	GKSession *aSession;
	UITextField *serverNameEdit;
	ServerCards *cardView;
    NSString *serverName;
    
    UIView *showCardsView;
    UIView *flipCardsView;
    UIView *valuesView;
    UILabel *minValue;
    UILabel *maxValue;
    UILabel *medianValue;
    
    BOOL cardFaceUp;
    UITapGestureRecognizer *tapGesture;
    
    UIWindow *externalWindow;
}

@property (nonatomic, retain) NSString *serverName;
@property (nonatomic, retain) IBOutlet UITextField *serverNameEdit;
@property (nonatomic, retain) IBOutlet ServerCards *cardView;
@property (nonatomic, retain) IBOutlet UIView *showCardsView;
@property (nonatomic, retain) IBOutlet UIView *flipCardsView;
@property (nonatomic, retain) IBOutlet UILabel *minValue;
@property (nonatomic, retain) IBOutlet UILabel *maxValue;
@property (nonatomic, retain) IBOutlet UILabel *medianValue;

@property (nonatomic, retain) UIWindow *externalWindow;


-(IBAction) createServerClick;
-(IBAction) flipCardsClick:(id) sender;
-(IBAction) resetCardsClick;
-(void) resetView;

@end
