//
//  WiFiSettingsTextViewCellModel.m
//  WifiConfig
//
//  Created by Pavan Goyal on 5/7/16.
//  Copyright © 2016 Pavan Goyal. All rights reserved.
//

#import "WiFiSettingsTextViewCellModel.h"

@implementation WiFiSettingsTextViewCellModel

- (instancetype)initWithFirstLabel:(NSString *)firstLabel secondLabel:(NSString *)secondLabel placeHolder:(NSString *)placeHolder tag:(NSInteger)tag {
    if (self = [super init]) {
        _firstLabel = firstLabel;
        _secondLabel = secondLabel;
        _placeHolder = placeHolder;
        _tag = tag;
    }
    return self;
}

- (instancetype)initWithSecondLabel:(NSString *)secondLabel placeHolder:(NSString *)placeHolder tag:(NSInteger)tag {
    return [self initWithFirstLabel:nil secondLabel:secondLabel placeHolder:placeHolder tag:tag];
}

@end
