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
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation WiFiSettingsTextViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)createCellWithModel:(WiFiSettingsTextViewCellModel *)cellModel {
    if (cellModel.firstLabel) {
        self.firstLabel.text = cellModel.firstLabel;
    }
    self.secondLabel.text = cellModel.secondLabel;
    self.textView.tag = cellModel.tag;
}

+ (CGFloat)heightWithTwoLabels {
    return 100;
}

+ (CGFloat)heightWithOneLabel {
    return 84;
}

@end
