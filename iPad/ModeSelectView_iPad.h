//
//  ModeSelectView_iPad.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrumClient.h"


@interface ModeSelectView_iPad : UIViewController {
    UIView *serverTab;
    UIView *clientTab;
    UITextField *serverName;
    UITextField *clientName;
    UIButton *serverTabButton;
    UIButton *clientTabButton;
    
    ScrumClient *client;
}

@property (nonatomic, retain) IBOutlet UITextField *clientName;
@property (nonatomic, retain) IBOutlet UITextField *serverName;
@property (nonatomic, retain) IBOutlet UIView *serverTab;
@property (nonatomic, retain) IBOutlet UIView *clientTab;
@property (nonatomic, retain) IBOutlet UIButton *serverTabButton;
@property (nonatomic, retain) IBOutlet UIButton *clientTabButton;

-(IBAction) serverTabClick;
-(IBAction) clientTabClick;

-(IBAction) createServerClick;
-(IBAction) createClientClick;
-(IBAction) connectToServerClick;

@end
