//
//  InAppPurchaseView_iPhone.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 12/3/11.
//  Copyright (c) 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InAppPurchaseManager.h"
#import <StoreKit/StoreKit.h>
#import "SKProduct+LocalizedPrice.h"

@interface InAppPurchaseView_iPhone : UIViewController<InAppPurchaseManagerDelegate> {
    InAppPurchaseManager *manager;
    UILabel *priceLabel;
    NSArray *products;
    
    UIButton *purchaseButton;
}

@property (nonatomic, retain) IBOutlet UILabel *priceLabel;
@property (nonatomic, retain) IBOutlet UIButton *purchaseButton;

-(IBAction) returnClick;
-(IBAction) purchaseProduct;


@end
