//
//  IconView.h
//  iTalk
//
//  Created by Chris Brandsma on 11/15/10.
//  Copyright 2010 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface IconView : UIScrollView {
}

-(void) clearView;
-(void) addTile: (UIView *)view;
-(void) removeTile: (UIView *) view;

@end
