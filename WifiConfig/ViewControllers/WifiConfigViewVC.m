//
//  ViewController.m
//  WifiConfig
//
//  Created by Pavan Goyal on 5/6/16.
//  Copyright © 2016 Pavan Goyal. All rights reserved.
//

#import "WifiConfigViewVC.h"
#import "WiFiSettingsHeaderView.h"
#import "WiFiSettingsTextViewCellModel.h"

@interface WifiConfigViewVC ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) WiFiSettingsHeaderView *navigationBarView;
@property (strong, nonatomic) NSArray *tableViewCellsData;

@end

@implementation WifiConfigViewVC

static const NSInteger kSsidTag = 100;
static const NSInteger kPasswordTag = 101;
static const NSInteger kIpTag = 102;
static const NSInteger kNetmaskTag = 103;
static const NSInteger kGatewayTag = 104;
static const NSInteger kDnsTag = 105;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarView = (WiFiSettingsHeaderView *)[[[NSBundle mainBundle] loadNibNamed:@"WiFiSettingsHeaderView" owner:self options:nil] objectAtIndex:0];
    self.navigationBarView.frame = CGRectMake(0, 0, self.view.bounds.size.width, [WiFiSettingsHeaderView height]);
    self.tableViewCellsData = [self createDataForTableViewCells];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.navigationBarView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationBarView removeFromSuperview];
}

- (NSArray *)createDataForTableViewCells {
    WiFiSettingsTextViewCellModel *ssidCellData = [[WiFiSettingsTextViewCellModel alloc] initWithSecondLabel:@"SSID" placeHolder:@"MyHomeWiFi" tag:kSsidTag];
    WiFiSettingsTextViewCellModel *passwordCellData = [[WiFiSettingsTextViewCellModel alloc] initWithSecondLabel:@"Password" placeHolder:@"Enter Password" tag:kPasswordTag];
    WiFiSettingsTextViewCellModel *ipCellData = [[WiFiSettingsTextViewCellModel alloc] initWithFirstLabel:@"DHCP" secondLabel:@"IP" placeHolder:@"192.168.0.10" tag:kIpTag];
    WiFiSettingsTextViewCellModel *netmaskCellData = [[WiFiSettingsTextViewCellModel alloc] initWithSecondLabel:@"Netmask" placeHolder:@"255.255.255.0" tag:kNetmaskTag];
    WiFiSettingsTextViewCellModel *gatewayCellData = [[WiFiSettingsTextViewCellModel alloc] initWithSecondLabel:@"Gateway" placeHolder:@"192.168.0.1" tag:kGatewayTag];
    WiFiSettingsTextViewCellModel *dnsCellData = [[WiFiSettingsTextViewCellModel alloc] initWithSecondLabel:@"DNS" placeHolder:@"8.8.8.8" tag:kDnsTag];
    NSArray *dataArray = @[ssidCellData, passwordCellData, ipCellData, netmaskCellData, gatewayCellData, dnsCellData];
    return dataArray;
}

@end
