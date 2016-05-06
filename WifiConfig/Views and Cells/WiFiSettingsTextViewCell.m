//
//  WiFiSettingsTextViewCell.m
//  WifiConfig
//
//  Created by Pavan Goyal on 5/6/16.
//  Copyright © 2016 Pavan Goyal. All rights reserved.
//

#import "WiFiSettingsTextViewCell.h"

@interface WiFiSettingsTextViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstAndSecondLabelVerticalSpacingConstraint;

@end

@implementation WiFiSettingsTextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)createCellWithModel:(WiFiSettingsTextViewCellModel *)cellModel {
    if (cellModel.firstLabel) {
        self.firstLabel.text = cellModel.firstLabel;
        self.firstLabelHeightConstraint.constant = 18;
        self.firstAndSecondLabelVerticalSpacingConstraint.constant = 16;
    }
    else {
        self.firstLabelHeightConstraint.constant = 0;
        self.firstAndSecondLabelVerticalSpacingConstraint.constant = 0;
    }
    self.secondLabel.text = cellModel.secondLabel;
    self.textField.tag = cellModel.tag;
    self.textField.placeholder = cellModel.placeHolder;
}

+ (CGFloat)heightWithTwoLabels {
    return 132;
}

+ (CGFloat)heightWithOneLabel {
    return 84;
}

@end
