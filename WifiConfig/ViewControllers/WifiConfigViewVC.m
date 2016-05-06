//
//  ViewController.m
//  WifiConfig
//
//  Created by Pavan Goyal on 5/6/16.
//  Copyright © 2016 Pavan Goyal. All rights reserved.
//

#import "WifiConfigViewVC.h"
#import "WiFiSettingsHeaderView.h"

@interface WifiConfigViewVC ()

@property (strong, nonatomic) WiFiSettingsHeaderView *navigationBarView;

@end

@implementation WifiConfigViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBarView = (WiFiSettingsHeaderView *)[[[NSBundle mainBundle] loadNibNamed:@"WiFiSettingsHeaderView" owner:self options:nil] objectAtIndex:0];
    self.navigationBarView.frame = CGRectMake(0, 0, self.view.bounds.size.width, [WiFiSettingsHeaderView height]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.navigationBarView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationBarView removeFromSuperview];
}

@end
