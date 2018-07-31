//
//  ViewController.m
//  ImageViewer
//
//  Created by zhouzhenxing on 2018/7/31.
//  Copyright © 2018年 ZX. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIEdgeInsets insets = UIApplication.sharedApplication.delegate.window.safeAreaInsets;
    CGRect bounds = self.view.bounds;
    CGRect rect = CGRectMake(bounds.origin.x + insets.left, bounds.origin.y + insets.top, bounds.size.width - insets.left - insets.right, bounds.size.height - insets.top - insets.bottom);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    UIImage *image = [UIImage imageNamed:@"test"];
    [imageView setImage:image];
    [self.view addSubview:imageView];
    
    // button
    CGRect buttonRect = CGRectMake(rect.size.width / 4, rect.size.height / 4 * 3, rect.size.width / 2, 30);
    UIButton *switchButton = [[UIButton alloc] initWithFrame:buttonRect];
    [switchButton setTitle:@"Switch to image list" forState:UIControlStateNormal];
    [switchButton addTarget:self action:@selector(switchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [switchButton setBackgroundColor:UIColor.grayColor];
    [self.view addSubview:switchButton];
}

- (void)switchButtonClick:(UIButton *)sender
{
    [sender setHidden:YES];
    
    UIEdgeInsets insets = UIApplication.sharedApplication.delegate.window.safeAreaInsets;
    CGRect bounds = self.view.bounds;
    CGRect rect = CGRectMake(bounds.origin.x + insets.left, bounds.origin.y + insets.top, bounds.size.width - insets.left - insets.right, bounds.size.height - insets.top - insets.bottom);
    UITableView *tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    [self.view addSubview:tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellID];
    }
    
    [cell.textLabel setText:@"title"];
    [cell.detailTextLabel setText:@"detailed text"];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
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

@end
