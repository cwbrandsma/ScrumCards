//
//  IconView.m
//  iTalk
//
//  Created by Chris Brandsma on 11/15/10.
//  Copyright 2010 DiamondB Software. All rights reserved.
//

#import "IconView.h"
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

@implementation IconView

static int rowHeaderHeight = 0;

static int itemsPerRow = 4;
static int itemWidth = 180;
static int itemHeight = 270;


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void) resizeScrollView {
	CGSize size = self.contentSize;
	int extraRowCount = 0;
	int itemCount = [self.subviews count];
	if (itemCount % itemsPerRow != 0)
		extraRowCount = 1;
	
	int rowCount = itemCount / itemsPerRow + extraRowCount;
	int height = rowHeaderHeight + (rowCount * itemHeight);
	size.height = height;
	
	self.contentSize = size;
}


-(void) setButtonPosition: (UIView *) button: (int) index{
	int row = index / itemsPerRow;
	int col = index % itemsPerRow;
	int y = rowHeaderHeight + (row * itemHeight);
	int x = itemWidth * col + 15; // + 10 is a redneck center for the cards
	
	button.frame = CGRectMake(x, y, itemWidth, itemHeight); 
}

int tileCount = 0;

-(void) removeTile: (UIView *) view {
    [view removeFromSuperview];
    tileCount--;
    [self resizeScrollView];    
}

-(void) addTile: (UIView *)view {
	//int count = [[self subviews] count];
    int count = tileCount;
	
	[self setButtonPosition:view :count];
	view.tag = count;
    
	[super addSubview:view];
	[self resizeScrollView];
    tileCount++;
    
}

-(void) addSubview:(UIView *)view {
	[super addSubview:view];
    
}

-(void) clearView {
	for (UIButton *b in [self subviews]) {
		[b removeFromSuperview];
	} 
    tileCount = 0;
}

- (void)dealloc {
    [super dealloc];
}


@end
