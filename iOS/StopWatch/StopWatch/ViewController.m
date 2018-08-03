//
//  ViewController.m
//  StopWatch
//
//  Created by zhouzhenxing on 2018/8/3.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import "ViewController.h"
#import "SWLayer.h"

@interface ViewController ()

@end

@implementation ViewController {
    CALayer *layerToDraw;
    NSDictionary *fontAttributes;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    int fontSize = 120;
    
    CGRect labelRect = self.view.bounds;
    labelRect.origin.y = (self.view.bounds.size.height - fontSize) / 2;
    labelRect.size.height = fontSize;
    
    layerToDraw = [[SWLayer alloc] initWithFontSize:fontSize];
    layerToDraw.frame = labelRect;
    layerToDraw.contentsScale = 2;

    [self.view.layer addSublayer:layerToDraw];
    [layerToDraw setNeedsDisplay];
    
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timeTick:) userInfo:nil repeats:YES];
}

- (void)timeTick:(NSTimer *)timer
{
    [layerToDraw setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
