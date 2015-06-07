//
//  SettingsView_iPad.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 3/7/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsView_iPad : UIViewController {
	UITextField *nameField;
}

@property (nonatomic, retain) IBOutlet UITextField *nameField;

-(IBAction) findServerClick;
-(IBAction) returnClick;

@end
