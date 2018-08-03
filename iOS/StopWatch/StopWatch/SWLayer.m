//
//  SWLayer.m
//  StopWatch
//
//  Created by zhouzhenxing on 2018/8/3.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import "SWLayer.h"

@implementation SWLayer {
    NSDictionary *fontAttributes;
    CGRect textRect;
}

- (instancetype)initWithFontSize:(int)fontSize
{
    self = [super init];
    if (self) {
        UIFont *font = [UIFont fontWithName:@"Courier" size:fontSize];
        NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
        textStyle.alignment = NSTextAlignmentCenter;
        fontAttributes = @{ NSFontAttributeName: font, NSForegroundColorAttributeName: UIColor.blackColor, NSParagraphStyleAttributeName: textStyle };
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"ss SS"];
    NSDate *currentDate = [NSDate date];
    
    UIGraphicsPushContext(ctx);
    [[formatter stringFromDate:currentDate] drawInRect:self.bounds withAttributes:fontAttributes];
    UIGraphicsPopContext();
}

@end
