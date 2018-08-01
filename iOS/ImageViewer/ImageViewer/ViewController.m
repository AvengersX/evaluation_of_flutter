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
    NSMutableArray *imageArray;
    NSMutableDictionary *imageDict;
    NSString *jsonUrl;
    CGRect rect;
}

- (id)init
{
    if (self = [super init]) {
        imageArray = [[NSMutableArray alloc] initWithCapacity:60];
        imageDict = [[NSMutableDictionary alloc] initWithCapacity:60];
        jsonUrl = @"http://image.baidu.com/channel/listjson?pn=0&rn=30&tag1=%E5%AE%A0%E7%89%A9&tag2=%E5%85%A8%E9%83%A8&ie=utf8";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIEdgeInsets insets = UIApplication.sharedApplication.delegate.window.safeAreaInsets;
    CGRect bounds = self.view.bounds;
    rect = CGRectMake(bounds.origin.x + insets.left, bounds.origin.y + insets.top, bounds.size.width - insets.left - insets.right, bounds.size.height - insets.top - insets.bottom);
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    UIImage *image = [UIImage imageNamed:@"test"];
    [imageView setImage:image];
    [self.view addSubview:imageView];
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(selectorLeftAction:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    // button
    CGRect buttonRect = CGRectMake(rect.size.width / 4, rect.size.height / 4 * 3, rect.size.width / 2, 30);
    _switchButton = [[UIButton alloc] initWithFrame:buttonRect];
    [_switchButton setTitle:@"Switch to image list" forState:UIControlStateNormal];
    [_switchButton addTarget:self action:@selector(switchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_switchButton setBackgroundColor:UIColor.grayColor];
    [self.view addSubview:_switchButton];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[[NSURL alloc] initWithString:jsonUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data) {
            NSDictionary *object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            if (object) {
                NSArray *imageItems = [object valueForKey:@"data"];
                if (imageItems) {
                    for (NSDictionary *item in imageItems) {
                        if (item.count > 0) {
                            [self->imageArray addObject:[item valueForKey:@"image_url"]];
                        }
                    }
                }
            }
        }
    }];
    [task resume];
}

-(void)selectorLeftAction:(id)sender
{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"点击了左侧" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];
    
    [_switchButton setHidden:FALSE];
    if(_tableView != nil)
        [_tableView setHidden:YES ];
    
}

- (void)switchButtonClick:(UIButton *)sender
{
    [sender setHidden:YES];
    
    
    if(_tableView == nil)
    {
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [_tableView setDataSource:self];
    [_tableView setDelegate:self];
    [self.view addSubview:_tableView];
    _tableView.rowHeight = rect.size.height / 2;
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
    IVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[IVTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    NSInteger pos = [indexPath indexAtPosition:1];
    NSString *imgUrl = [imageArray objectAtIndex:pos];
    
    if ([imageDict valueForKey:imgUrl] == nil) {
        //[imageDict setObject:imgUrl forKey:[NSNull null]];
        
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[[NSURL alloc] initWithString:imgUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *img = [UIImage imageWithData:data];
                //[self->imageDict setObject:img forKey:imgUrl];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                [cell.ivImageView setFrame:cell.bounds];
                cell.ivImageView.image = img;
                [cell setNeedsLayout];
                });
            }
        }];
        [task resume];
    }
    else {
        UIImage *img = [imageDict valueForKey:imgUrl];
        if ([img isKindOfClass:[UIImage class]]) {
            cell.ivImageView.image = img;
            [cell layoutIfNeeded];
        }
    }
    
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
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
    return rect.size.height / 2;
}

@end
