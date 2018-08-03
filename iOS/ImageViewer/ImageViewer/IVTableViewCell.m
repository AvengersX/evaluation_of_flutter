//
//  IVTableViewCell.m
//  ImageViewer
//
//  Created by zhouzhenxing on 2018/8/1.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import "IVTableViewCell.h"

@implementation IVTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGRect textRect = self.frame;
        
        _ivTextView = [[UITextView alloc] initWithFrame:textRect];
        [_ivTextView setTextColor:UIColor.blackColor];
        [_ivTextView setEditable:NO];
        [_ivTextView setSelectable:NO];
         [_ivTextView setFont:[UIFont fontWithName:@"Arial" size:40]];
        
        CGRect imageRect = self.frame;
        _ivImageView = [[UIImageView alloc] initWithFrame:imageRect];
        [_ivImageView setContentMode:UIViewContentModeScaleToFill];
        [_ivImageView setClipsToBounds:YES];
        [self.contentView addSubview:_ivImageView];
        [self.contentView addSubview:_ivTextView];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
