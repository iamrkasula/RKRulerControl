//
//  RKScaleView.m
//  ScrollViewRuler
//
//  Created by Rajesh kasula on 02/10/17.
//  Copyright © 2017 rkasula. All rights reserved.
//

#import "RKScaleView.h"
#import "RKTickerView.h"

@interface RKScaleView() < UIScrollViewDelegate >
{
    UIImageView *_arrowImageView;
    UIScrollView *_scrollView;
    NSArray *_tickers;
    UIView *_scaleView;
}
@end

@implementation RKScaleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaults];
    }
    return self;
}

- (void)setupDefaults
{
     _startValue = 0;
    _endValue = 200;
    _numberOfTicksBetweenValues = 10;
   _spaceBetweenTicks = 10.0;
   _tickColor = [UIColor blackColor];
    _arrowColor = [UIColor orangeColor];
    
    // ScrollView
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    _scaleView = [[UIView alloc] init];
    [_scrollView addSubview:_scaleView];
    
    // Arrow Image
    _arrowImageView = [[UIImageView alloc] init];
    _arrowImageView.image = [self image:[UIImage imageNamed:@"triangle"] WithColor:_arrowColor];
    [self addSubview:_arrowImageView];
    
    [self prepareTickers];

}

- (void)prepareTickers
{
    NSMutableArray *views = [NSMutableArray new];
    for (NSInteger index = _startValue; index <= _endValue; index ++) {
        RKTickerType tickerType = ((index % 10) == 0 ? RKTickerTypeLong : RKTickerTypeShort);
        CGFloat yPos = 0;
        if (views.count > 0) {
            RKTickerView *lastView = [views lastObject];
            yPos = CGRectGetMaxY(lastView.frame);
        }
        CGRect tickerViewFrame = CGRectMake(0, yPos, CGRectGetWidth(self.frame), _spaceBetweenTicks);
        RKTickerView *view = [[RKTickerView alloc] initWithType:tickerType];
        view.frame = tickerViewFrame;
        //view.backgroundColor = (index % 2) == 0 ? [UIColor lightGrayColor] : [UIColor whiteColor];
        [view setScaleText:@(index).stringValue];
        view.scaleId = index;
        [_scaleView addSubview:view];
        [views addObject:view];
    }
    _tickers = [views copy];
}

- (void)setupScale
{
    _scaleView.frame = CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), _tickers.count * _spaceBetweenTicks);
    for (NSInteger index = 0; index < _tickers.count; index ++) {
        RKTickerView *scaleView = [_tickers objectAtIndex:index];
        CGRect frame = scaleView.frame;
        frame.size.width = CGRectGetWidth(_scrollView.frame);
        [scaleView setFrame:frame];
    }
    
    _scrollView.contentSize = _scaleView.frame.size;
    CGFloat contentOffset = (CGRectGetHeight(_scrollView.frame)/2) - (CGRectGetHeight(_arrowImageView.frame)/2);
    [_scrollView setContentInset:UIEdgeInsetsMake(contentOffset, 0, contentOffset, 0)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateFrames];
    [self setupScale];
    [self updateSelectedValue];
}

- (void)updateFrames
{
    _arrowImageView.frame = CGRectMake(CGRectGetWidth(self.bounds) - 15, (CGRectGetHeight(self.bounds)/2) - (10/2), 15, 10);
    _scrollView.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    _scaleView.frame = CGRectMake(0, 0, _scrollView.frame.size.width, _tickers.count * _spaceBetweenTicks);
}

#pragma mark - ScrollView Delegates
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self updateSelectedValue];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self updateSelectedValue];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateSelectedValue];
}


- (void)updateSelectedValue
{
    if ([self.delegate respondsToSelector:@selector(rk_scaleView:value:)]) {
        [self.delegate rk_scaleView:self value:@([self viewIntersects:_arrowImageView withViews:_tickers])];
    }
}


#pragma mark - Helpers

- (UIImage *)image:(UIImage *)image WithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClipToMask(context, rect, image.CGImage);
    CGContextSetFillColorWithColor(context, [[UIColor redColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();    
    UIImage *flippedImage = [UIImage imageWithCGImage:img.CGImage scale:1.0 orientation: UIImageOrientationDownMirrored];
    return flippedImage;
}

- (NSInteger )viewIntersects:(UIView *)topView withViews:(NSArray *)views
{
    for (RKTickerView *theView in views)
    {
        CGRect boundsA = [theView convertRect:theView.bounds toView:nil];
        CGRect boundsB = [topView convertRect:topView.bounds toView:nil];
        if (CGRectIntersectsRect(boundsA, boundsB))
        {
            return theView.scaleId;
        }
    }
    return 0;
}
@end
