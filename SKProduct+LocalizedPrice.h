//
//  SKProduct+LocalizedPrice.h
//  ScrumBoard
//
//  Created by Chris Brandsma on 12/3/11.
//  Copyright (c) 2011 DiamondB Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface SKProduct (LocalizedPrice)

@property (nonatomic, readonly) NSString *localizedPrice;

@end