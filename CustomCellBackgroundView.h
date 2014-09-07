//
//  CustomCellBackgroundView.h
//  ApplePan
//
//  Created by ye tao on 12-9-23.
//  Copyright (c) 2012年 衍生科技. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    CustomCellBackgroundViewPositionTop,
    CustomCellBackgroundViewPositionMiddle,
    CustomCellBackgroundViewPositionBottom,
    CustomCellBackgroundViewPositionSingle
} CustomCellBackgroundViewPosition;

@interface CustomCellBackgroundView : UIView
{
    UIColor *borderColor;
    UIColor *fillColor;
    CustomCellBackgroundViewPosition position;
}
@property(nonatomic, retain) UIColor *borderColor, *fillColor;
@property(nonatomic) CustomCellBackgroundViewPosition position;
@end
