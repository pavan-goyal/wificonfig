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

- (instancetype) init;

@end
