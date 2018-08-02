//
//  ViewController.m
//  ImageViewer
//
//  Created by zhouzhenxing on 2018/7/31.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import "ViewController.h"
#import "IVTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController {
    CGRect rect;
}

- (id)init
{
    if (self = [super init]) {
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    rect = [[UIScreen mainScreen] bounds];
    
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [self.view addSubview:_tableView];
    _tableView.rowHeight = rect.size.height / 2 + rect.size.height / 5;
}

- (void)switchButtonClick:(UIButton *)sender
{
    [sender setHidden:YES];
    
    
    if(_tableView == nil)
    {
        
    }
    else
        [_tableView setHidden:FALSE ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    NSInteger pos = [indexPath indexAtPosition:1];

    IVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[IVTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *name = [NSString stringWithFormat:@"p%li", pos + 1];
        UIImage *img = [UIImage imageNamed:name];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            CGRect imageRect = cell.bounds;
            imageRect.origin.y += cell.bounds.size.height* 2/7;
            imageRect.size.height = imageRect.size.height* 5/7;
            
//                CGRect bound = cell.bounds;
//                bound.size.height = cell.bounds.size.height *5/7;
            [cell.ivImageView setFrame:imageRect];
            cell.ivImageView.image = img;
            
            CGRect textRect = cell.bounds;
            textRect.size.height = textRect.size.height* 2/7;
            
            [cell.ivTextView setText:[NSString stringWithFormat:@"hello word %li", pos + 1]];
            [cell.ivTextView setFrame:textRect];
            //[cell setNeedsLayout];
        });
    });
        
        return cell;

}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 31;
}

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (CGSize)sizeForChildContentContainer:(nonnull id<UIContentContainer>)container withParentContainerSize:(CGSize)parentSize {
    return CGSizeZero;
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    
}

- (void)setNeedsFocusUpdate {
    
}

- (BOOL)shouldUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context {
    return YES;
}

- (void)updateFocusIfNeeded {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rect.size.height * 7 / 10;
}

@end
