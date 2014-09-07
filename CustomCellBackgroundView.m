//
//  CustomCellBackgroundView.m
//  ApplePan
//
//  Created by ye tao on 12-9-23.
//  Copyright (c) 2012年 衍生科技. All rights reserved.
//

#import "CustomCellBackgroundView.h"

static void addRoundedRectToPath(CGContextRef context, CGRect rect,
                                 float ovalWidth,float ovalHeight);

@implementation CustomCellBackgroundView
@synthesize borderColor, fillColor, position;

- (BOOL) isOpaque
{
    return NO;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(c, [fillColor CGColor]);
    CGContextSetStrokeColorWithColor(c, [borderColor CGColor]);
    
    if (position == CustomCellBackgroundViewPositionTop)
    {
        CGContextFillRect(c, CGRectMake(0.0f, rect.size.height - 10.0f, rect.size.width, 10.0f));
        CGContextBeginPath(c);
        CGContextMoveToPoint(c, 0.0f, rect.size.height - 10.0f);
        CGContextAddLineToPoint(c, 0.0f, rect.size.height);
        CGContextAddLineToPoint(c, rect.size.width, rect.size.height);
        CGContextAddLineToPoint(c, rect.size.width, rect.size.height - 10.0f);
        CGContextStrokePath(c);
        CGContextClipToRect(c, CGRectMake(0.0f, 0.0f, rect.size.width, rect.size.height - 10.0f));
    }
    else if (position == CustomCellBackgroundViewPositionBottom)
    {
        CGContextFillRect(c, CGRectMake(0.0f, 0.0f, rect.size.width, 10.0f));
        CGContextBeginPath(c);
        CGContextMoveToPoint(c, 0.0f, 10.0f);
        CGContextAddLineToPoint(c, 0.0f, 0.0f);
        CGContextStrokePath(c);
        CGContextBeginPath(c);
        CGContextMoveToPoint(c, rect.size.width, 0.0f);
        CGContextAddLineToPoint(c, rect.size.width, 10.0f);
        CGContextStrokePath(c);
        CGContextClipToRect(c, CGRectMake(0.0f, 10.0f, rect.size.width, rect.size.height));
    }
    else if (position == CustomCellBackgroundViewPositionMiddle)
    {
        CGContextFillRect(c, rect);
        CGContextBeginPath(c);
        CGContextMoveToPoint(c, 0.0f, 0.0f);
        CGContextAddLineToPoint(c, 0.0f, rect.size.height);
        CGContextAddLineToPoint(c, rect.size.width, rect.size.height);
        CGContextAddLineToPoint(c, rect.size.width, 0.0f);
        CGContextStrokePath(c);
        return; // no need to bother drawing rounded corners, so we return
    }
    
    // At this point the clip rect is set to only draw the appropriate
    // corners, so we fill and stroke a rounded rect taking the entire rect
    
    CGContextBeginPath(c);
    addRoundedRectToPath(c, rect, 10.0f, 10.0f);
    CGContextFillPath(c);
    
    CGContextSetLineWidth(c, 1);
    CGContextBeginPath(c);
    addRoundedRectToPath(c, rect, 10.0f, 10.0f);
    CGContextStrokePath(c);
}
//Thank you for the code, it's just what I was looking for. I have also added the following code to Vimal's code, to implement the case of a CustomCellBackgroundViewPositionSingle cell. (All four corners are rounded.)
//else if (position == CustomCellBackgroundViewPositionSingle)
//{
//    CGFloat minx = CGRectGetMinX(rect) , midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect) ;
//    CGFloat miny = CGRectGetMinY(rect) , midy = CGRectGetMidY(rect) , maxy = CGRectGetMaxY(rect) ;
//    minx = minx + 1;
//    miny = miny + 1;
//    
//    maxx = maxx - 1;
//    maxy = maxy - 1;
//    
//    CGContextMoveToPoint(c, minx, midy);
//    CGContextAddArcToPoint(c, minx, miny, midx, miny, ROUND_SIZE);
//    CGContextAddArcToPoint(c, maxx, miny, maxx, midy, ROUND_SIZE);
//    CGContextAddArcToPoint(c, maxx, maxy, midx, maxy, ROUND_SIZE);
//    CGContextAddArcToPoint(c, minx, maxy, minx, midy, ROUND_SIZE);
//    
//    // Close the path
//    CGContextClosePath(c);
//    // Fill & stroke the path
//    CGContextDrawPath(c, kCGPathFillStroke);
//    return;
//}
//First of all thanks for this code. I have made some drawing changes in this function to remove corner problem of drawing.
/*
-(void)drawRect:(CGRect)rect
{
    // Drawing code
    
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(c, [fillColor CGColor]);
    CGContextSetStrokeColorWithColor(c, [borderColor CGColor]);
    CGContextSetLineWidth(c, 2);
    
    if (position == CustomCellBackgroundViewPositionTop) {
        
    	CGFloat minx = CGRectGetMinX(rect) , midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect) ;
    	CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ;
    	minx = minx + 1;
    	miny = miny + 1;
        
    	maxx = maxx - 1;
    	maxy = maxy ;
        
    	CGContextMoveToPoint(c, minx, maxy);
    	CGContextAddArcToPoint(c, minx, miny, midx, miny, ROUND_SIZE);
    	CGContextAddArcToPoint(c, maxx, miny, maxx, maxy, ROUND_SIZE);
    	CGContextAddLineToPoint(c, maxx, maxy);
        
    	// Close the path
    	CGContextClosePath(c);
    	// Fill & stroke the path
    	CGContextDrawPath(c, kCGPathFillStroke);
    	return;
    } else if (position == CustomCellBackgroundViewPositionBottom) {
        
    	CGFloat minx = CGRectGetMinX(rect) , midx = CGRectGetMidX(rect), maxx = CGRectGetMaxX(rect) ;
    	CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ;
    	minx = minx + 1;
    	miny = miny ;
        
    	maxx = maxx - 1;
    	maxy = maxy - 1;
        
    	CGContextMoveToPoint(c, minx, miny);
    	CGContextAddArcToPoint(c, minx, maxy, midx, maxy, ROUND_SIZE);
    	CGContextAddArcToPoint(c, maxx, maxy, maxx, miny, ROUND_SIZE);
    	CGContextAddLineToPoint(c, maxx, miny);
    	// Close the path
    	CGContextClosePath(c);
    	// Fill & stroke the path
    	CGContextDrawPath(c, kCGPathFillStroke);
    	return;
    } else if (position == CustomCellBackgroundViewPositionMiddle) {
        CGFloat minx = CGRectGetMinX(rect) , maxx = CGRectGetMaxX(rect) ;
    	CGFloat miny = CGRectGetMinY(rect) , maxy = CGRectGetMaxY(rect) ;
    	minx = minx + 1;
    	miny = miny ;
        
    	maxx = maxx - 1;
    	maxy = maxy ;
        
    	CGContextMoveToPoint(c, minx, miny);
    	CGContextAddLineToPoint(c, maxx, miny);
    	CGContextAddLineToPoint(c, maxx, maxy);
    	CGContextAddLineToPoint(c, minx, maxy);
        
    	CGContextClosePath(c);
    	// Fill & stroke the path
    	CGContextDrawPath(c, kCGPathFillStroke);	
    	return;
    }
}*/

/*
I know the answers are relating to changing grouped table cells, but in case someone is wanting to also change the tableview's background color:

Not only do you need to set:

tableview.backgroundColor = color;
You also need to change or get rid of the background view:

tableview.backgroundView = nil;
 */

- (void)dealloc
{
    [borderColor release];
    [fillColor release];
    [super dealloc];
}

@end

static void addRoundedRectToPath(CGContextRef context, CGRect rect,
                                 float ovalWidth,float ovalHeight)

{
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0)
    {// 1
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);// 2
    
    CGContextTranslateCTM (context, CGRectGetMinX(rect),// 3
                           CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight);// 4
    fw = CGRectGetWidth (rect) / ovalWidth;// 5
    fh = CGRectGetHeight (rect) / ovalHeight;// 6
    
    CGContextMoveToPoint(context, fw, fh/2); // 7
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);// 8
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1);// 9
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1);// 10
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // 11
    CGContextClosePath(context);// 12
    
    CGContextRestoreGState(context);// 13
}
