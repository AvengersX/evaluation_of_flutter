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
        _ivImageView = [[UIImageView alloc] initWithFrame:self.frame];
        [_ivImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_ivImageView setClipsToBounds:YES];
        [self.contentView addSubview:_ivImageView];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
