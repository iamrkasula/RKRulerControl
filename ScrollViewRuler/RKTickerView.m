//
//  ScaleView.m
//  ScrollViewRuler
//
//  Created by Rajesh kasula on 02/10/17.
//  Copyright © 2017 rkasula. All rights reserved.
//

#import "RKTickerView.h"

#define LARGE_SCALE_WIDTH 35
#define SMALL_SCALE_WIDTH 20

@interface RKTickerView()
{
    UILabel *_textLabel;
    UIView *_pointerView;
    CGFloat alwaysOnePixelInPointUnits;
}
@end

@implementation RKTickerView

-(instancetype)initWithType:(RKTickerType)type
{
    self = [super init];
    if (self) {
        _type = type;
        CGFloat scaleOfMainScreen = [UIScreen mainScreen].scale;
        alwaysOnePixelInPointUnits = 1.0/scaleOfMainScreen;
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    if (_type == RKTickerTypeLong) {
        
        _pointerView = [UIView new];
        _pointerView.backgroundColor = [UIColor blackColor];
        [self addSubview:_pointerView];
        
        _textLabel = [UILabel new];
        _textLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [_textLabel sizeToFit];
        _textLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_textLabel];
    }
    else
    {
        _pointerView = [UIView new];
        _pointerView.frame = CGRectMake(CGRectGetWidth(self.bounds) - SMALL_SCALE_WIDTH, CGRectGetMidY(self.bounds), SMALL_SCALE_WIDTH, alwaysOnePixelInPointUnits);
        _pointerView.backgroundColor = [UIColor blackColor];
        [self addSubview:_pointerView];
        
    }
    
}

-(void)setScaleText:(NSString *)scaleText
{
    [_textLabel setText:scaleText];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateFrames];
}
- (void)updateFrames
{
    if (_type == RKTickerTypeLong)
    {
    _pointerView.frame = CGRectMake(CGRectGetWidth(self.bounds) - LARGE_SCALE_WIDTH, CGRectGetMidY(self.bounds), LARGE_SCALE_WIDTH, alwaysOnePixelInPointUnits);
        CGSize textSize = [_textLabel.text sizeWithAttributes:@{NSFontAttributeName:[_textLabel font]}];
    _textLabel.frame = CGRectMake(CGRectGetMinX(_pointerView.frame) - (textSize.width  + 5), CGRectGetMidY(self.bounds)- (textSize.height/2), textSize.width, textSize.height);
    }else{
        _pointerView.frame = CGRectMake(CGRectGetWidth(self.bounds) - SMALL_SCALE_WIDTH, CGRectGetMidY(self.bounds), SMALL_SCALE_WIDTH, alwaysOnePixelInPointUnits);
    }
}
@end
