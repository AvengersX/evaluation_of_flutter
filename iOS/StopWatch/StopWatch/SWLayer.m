//
//  SWLayer.m
//  StopWatch
//
//  Created by zhouzhenxing on 2018/8/3.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import "SWLayer.h"
#import <time.h>
#import <stdio.h>
#import <stdlib.h>

@implementation SWLayer {
    NSDictionary *fontAttributes;
}

- (instancetype)initWithFontSize:(int)fontSize
{
    self = [super init];
    if (self) {
        UIFont *font = [UIFont fontWithName:[UIFont systemFontOfSize:10].fontName size:fontSize];
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        //textStyle.alignment = NSTextAlignmentCenter;
        fontAttributes = @{ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle };
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx
{
    struct timespec spec;
    clock_gettime(CLOCK_REALTIME, &spec);
    int sec = spec.tv_sec % 60;
    int msec = spec.tv_nsec / 1.0e7;
    msec %= 100;
    char str[6] = { 0 };
    str[0] = '0' + (sec / 10);
    str[1] = '0' + (sec % 10);
    str[2] = ' ';
    str[3] = '0' + (msec / 10);
    str[4] = '0' + (msec % 10);
    
    
    NSString *res = [NSString stringWithCString:str encoding:NSASCIIStringEncoding];
    //NSString *res = [NSString stringWithFormat:@"%02i %02i", sec, msec];
    
    UIGraphicsPushContext(ctx);
    //[res drawAtPoint:self.bounds.origin withAttributes:fontAttributes];
    [res drawInRect:self.bounds withAttributes:fontAttributes];
    UIGraphicsPopContext();
}

@end
