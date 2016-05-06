//
//  WiFiSettingsTextViewCell.h
//  WifiConfig
//
//  Created by Pavan Goyal on 5/6/16.
//  Copyright © 2016 Pavan Goyal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WiFiSettingsTextViewCellModel.h"

@interface WiFiSettingsTextViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *textField;

- (void)createCellWithModel:(WiFiSettingsTextViewCellModel *)cellModel;
+ (CGFloat)heightWithTwoLabels;
+ (CGFloat)heightWithOneLabel;

@end
