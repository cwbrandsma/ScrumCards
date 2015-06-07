//
//  InAppPurchaseManager.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 12/3/11.
//  Copyright (c) 2011 DiamondB Software. All rights reserved.
//

#import <StoreKit/StoreKit.h>

#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"
#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"


@protocol InAppPurchaseManagerDelegate <NSObject>

-(void) productsAvailableForPurchase: (NSArray *) products;
@optional
-(void) productWasPurchased: (SKPayment*) payment;
-(void) productPurchaseFailed;

@end

@interface InAppPurchaseManager : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>
{
    id<InAppPurchaseManagerDelegate> delegate;
    SKProduct *noAdsProduct;
    SKProductsRequest *productsRequest;
    NSArray *_products;
}


@property (nonatomic, assign) id<InAppPurchaseManagerDelegate> delegate;
@property (nonatomic, retain) NSArray* products;

// public methods
- (void)loadStore;
- (BOOL)canMakePurchases;
- (void)purchaseProUpgrade;
- (void) purchaseProduct: (SKProduct *) product;

+(BOOL) showAds;

@end