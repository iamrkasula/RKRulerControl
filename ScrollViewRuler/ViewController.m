//
//  ViewController.m
//  ScrollViewRuler
//
//  Created by Rajesh kasula on 02/10/17.
//  Copyright © 2017 rkasula. All rights reserved.
//

#import "ViewController.h"
#import "RKTickerView.h"
#import "RKScaleView.h"

@interface ViewController ()<UIScrollViewDelegate, RKScaleViewDelegate>

@property (nonatomic, weak) IBOutlet UILabel *heightLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RKScaleView *view = [[RKScaleView alloc] init];
    view.delegate = self;
    view.frame = CGRectMake(self.view.frame.size.width - 150, (self.view.frame.size.height/2) - 150, 150, 300);
    [self.view addSubview:view];
}

- (void)rk_scaleView:(RKScaleView *)scaleView value:(NSNumber *)value
{
    [self.heightLabel setText:value.stringValue];
}

@end
