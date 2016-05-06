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
#import "WiFiSettingsTextViewCell.h"
#import "WifiConfigModel.h"

@interface WifiConfigViewVC ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) WiFiSettingsHeaderView *navigationBarView;
@property (strong, nonatomic) NSArray *tableViewCellsData;
@property (strong, nonatomic) WifiConfigModel *configModel;

@end

@implementation WifiConfigViewVC

static const NSInteger kSsidTag = 100;
static const NSInteger kPasswordTag = 101;
static const NSInteger kIpTag = 102;
static const NSInteger kNetmaskTag = 103;
static const NSInteger kGatewayTag = 104;
static const NSInteger kDnsTag = 105;
static NSString *kTextViewCellReuseIdentifier = @"text_view_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarView = (WiFiSettingsHeaderView *)[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WiFiSettingsHeaderView class]) owner:self options:nil] objectAtIndex:0];
    self.navigationBarView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [WiFiSettingsHeaderView height]);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WiFiSettingsTextViewCell class]) bundle:nil] forCellReuseIdentifier:kTextViewCellReuseIdentifier];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.navigationBarView];
    self.configModel = [[WifiConfigModel alloc]init];
    self.tableViewCellsData = [self createDataForTableViewCells];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationBarView removeFromSuperview];
}

#pragma mark - UITableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tableViewCellsData count];
}

- (WiFiSettingsTextViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WiFiSettingsTextViewCellModel *cellModel = self.tableViewCellsData[indexPath.row];
    WiFiSettingsTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTextViewCellReuseIdentifier forIndexPath:indexPath];
    [cell createCellWithModel:cellModel];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WiFiSettingsTextViewCellModel *cellModel = self.tableViewCellsData[indexPath.row];
    if (cellModel.firstLabel) {
        return [WiFiSettingsTextViewCell heightWithTwoLabels];
    }
    else {
        return [WiFiSettingsTextViewCell heightWithOneLabel];
    }
}

- (IBAction)saveButtonClicked:(UIButton *)sender {
    /* Data is getting saved in model everytime user changes configuration in textfield. Do whatever you want to do with "self.configModel" here in this function. Here I am showing alert.
     */
    [self showAlert];
}

#pragma mark - Private Methods

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

- (void)showAlert {
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"WiFiConfig" message:@"Data has been saved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

@end
