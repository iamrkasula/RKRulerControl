//
//  RKScaleView.h
//  ScrollViewRuler
//
//  Created by Rajesh kasula on 02/10/17.
//  Copyright © 2017 rkasula. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RKScaleView;
@protocol RKScaleViewDelegate <NSObject>
- (void)rk_scaleView:(RKScaleView *)scaleView value:(NSNumber *)value;
@end


@interface RKScaleView : UIView

@property (nonatomic, assign) NSInteger startValue;

@property (nonatomic, assign) NSInteger endValue;

@property (nonatomic, assign) NSInteger numberOfTicksBetweenValues;

@property (nonatomic, strong) UIColor *tickColor;

@property (nonatomic, assign) CGFloat spaceBetweenTicks;

@property (nonatomic, strong) UIColor *arrowColor;

@property (nonatomic, unsafe_unretained) id <RKScaleViewDelegate> delegate;

@end
