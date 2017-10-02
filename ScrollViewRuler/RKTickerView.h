//
//  ScaleView.h
//  ScrollViewRuler
//
//  Created by Rajesh Kasula on 02/10/17.
//  Copyright © 2017 rkasula. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RKTickerType) {
    RKTickerTypeShort,
    RKTickerTypeLong
};

@interface RKTickerView : UIView
@property (nonatomic, assign) RKTickerType type;
@property (nonatomic, strong) NSString *scaleText;
@property (nonatomic, assign) NSInteger scaleId;

- (instancetype)initWithType:(RKTickerType)type;

@end
