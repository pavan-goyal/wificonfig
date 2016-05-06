//
//  WiFiSettingsTextViewCellModel.h
//  WifiConfig
//
//  Created by Pavan Goyal on 5/7/16.
//  Copyright © 2016 Pavan Goyal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WiFiSettingsTextViewCellModel : NSObject

@property (nonatomic, strong) NSString *firstLabel;
@property (nonatomic, strong) NSString *secondLabel;
@property (nonatomic, strong) NSString *placeHolder;
@property (nonatomic, assign) NSInteger tag;

- (instancetype)initWithFirstLabel:(NSString *)firstLabel secondLabel:(NSString *)secondLabel placeHolder:(NSString *)placeHolder tag:(NSInteger)tag;
- (instancetype)initWithSecondLabel:(NSString *)secondLabel placeHolder:(NSString *)placeHolder tag:(NSInteger)tag;

@end
