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

@interface WifiConfigViewVC ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) WiFiSettingsHeaderView *navigationBarView;
@property (strong, nonatomic) NSArray *tableViewCellsData;
@property (strong, nonatomic) WifiConfigModel *configModel;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *pickerArray;
@property (strong, nonatomic) UIToolbar *toolBar;
@property (strong, nonatomic) UITextField *currentTextField;

@end

@implementation WifiConfigViewVC

static const NSInteger kSsidTag = 100;
static const NSInteger kPasswordTag = 101;
static const NSInteger kIpTag = 102;
static const NSInteger kNetmaskTag = 103;
static const NSInteger kGatewayTag = 104;
static const NSInteger kDnsTag = 105;
static const NSInteger kSecurityTag = 106;
static NSString *kTextViewCellReuseIdentifier = @"text_view_cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBarView = (WiFiSettingsHeaderView *)[[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WiFiSettingsHeaderView class]) owner:self options:nil] objectAtIndex:0];
    self.navigationBarView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [WiFiSettingsHeaderView height]);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WiFiSettingsTextViewCell class]) bundle:nil] forCellReuseIdentifier:kTextViewCellReuseIdentifier];
    [self addPickerView];
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

- (void)addPickerView {
    self.pickerArray = @[@"None",@"WEP",@"WPA/WPA2 Personal",@"WPA2 Personal",@"Dynamic WEP",@"WPA/WPA2 Enterprise",@"WPA2 Enterprise"];
    self.pickerView = [[UIPickerView alloc]init];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = YES;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"Done" style:UIBarButtonItemStyleDone
                                   target:self action:@selector(done)];
    self.toolBar = [[UIToolbar alloc]initWithFrame:
                          CGRectMake(0, self.view.frame.size.height-
                                     self.pickerView.frame.size.height-50, [[UIScreen mainScreen] bounds].size.width, 40)];
    [self.toolBar setBarStyle:UIBarStyleBlackOpaque];
    NSArray *toolbarItems = [NSArray arrayWithObjects:
                             doneButton, nil];
    [self.toolBar setItems:toolbarItems];
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
    cell.textField.delegate = self;
    if (cellModel.tag == kSecurityTag) {
        cell.textField.inputView = self.pickerView;
        cell.textField.inputAccessoryView = self.toolBar;
    }
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

#pragma mark - Picker View Data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerArray count];
}

#pragma mark- Picker View Delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.configModel.security = [self.pickerArray objectAtIndex:row];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow: (NSInteger)row forComponent:(NSInteger)component {
    return [self.pickerArray objectAtIndex:row];
}

#pragma mark - UITextField Delegate Methods

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self saveDataOfTextField:textField];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.currentTextField = textField;
}

- (IBAction)saveButtonClicked:(UIButton *)sender {
    [self.currentTextField resignFirstResponder];
    [self showAlert];
}

#pragma mark - Private Methods

- (NSArray *)createDataForTableViewCells {
    WiFiSettingsTextViewCellModel *ssidCellData = [[WiFiSettingsTextViewCellModel alloc] initWithSecondLabel:@"SSID" placeHolder:@"MyHomeWiFi" tag:kSsidTag];
    WiFiSettingsTextViewCellModel *securityCellData = [[WiFiSettingsTextViewCellModel alloc] initWithSecondLabel:@"Security" placeHolder:@"Select security" tag:kSecurityTag];
    WiFiSettingsTextViewCellModel *passwordCellData = [[WiFiSettingsTextViewCellModel alloc] initWithSecondLabel:@"Password" placeHolder:@"Enter Password" tag:kPasswordTag];
    WiFiSettingsTextViewCellModel *ipCellData = [[WiFiSettingsTextViewCellModel alloc] initWithFirstLabel:@"DHCP" secondLabel:@"IP" placeHolder:@"192.168.0.10" tag:kIpTag];
    WiFiSettingsTextViewCellModel *netmaskCellData = [[WiFiSettingsTextViewCellModel alloc] initWithSecondLabel:@"Netmask" placeHolder:@"255.255.255.0" tag:kNetmaskTag];
    WiFiSettingsTextViewCellModel *gatewayCellData = [[WiFiSettingsTextViewCellModel alloc] initWithSecondLabel:@"Gateway" placeHolder:@"192.168.0.1" tag:kGatewayTag];
    WiFiSettingsTextViewCellModel *dnsCellData = [[WiFiSettingsTextViewCellModel alloc] initWithSecondLabel:@"DNS" placeHolder:@"8.8.8.8" tag:kDnsTag];
    NSArray *dataArray = @[ssidCellData, securityCellData, passwordCellData, ipCellData, netmaskCellData, gatewayCellData, dnsCellData];
    return dataArray;
}

- (void)showAlert {
    UIAlertView * alert =[[UIAlertView alloc ] initWithTitle:@"WiFiConfig" message:@"Data has been saved." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (void)saveDataOfTextField:(UITextField *)textField {
    if (textField.tag == kSsidTag) {
        self.configModel.ssid = textField.text;
    }
    else if (textField.tag == kPasswordTag) {
        self.configModel.password = textField.text;
    }
    else if (textField.tag == kNetmaskTag) {
        self.configModel.netmask = textField.text;
    }
    else if (textField.tag == kIpTag) {
        self.configModel.ip = textField.text;
    }
    else if (textField.tag == kGatewayTag) {
        self.configModel.gateway = textField.text;
    }
    else if (textField.tag == kDnsTag) {
        self.configModel.dns = textField.text;
    }
    else if (textField.tag == kSecurityTag) {
        self.configModel.security = textField.text;
    }
}

- (void)done {
    NSInteger row = [self.pickerView selectedRowInComponent:0];
    self.currentTextField.text = [self.pickerArray objectAtIndex:row];
    [self.currentTextField resignFirstResponder];
}

@end
