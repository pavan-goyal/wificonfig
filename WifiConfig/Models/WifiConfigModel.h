//
//  WifiConfigModel.h
//  WifiConfig
//
//  Created by Pavan Goyal on 5/6/16.
//  Copyright © 2016 Pavan Goyal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WifiConfigModel : NSObject

@property (nonatomic, strong) NSString *ssid;
@property (nonatomic, strong) NSString *security;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *ip;
@property (nonatomic, strong) NSString *netmask;
@property (nonatomic, strong) NSString *gateway;
@property (nonatomic, strong) NSString *dns;

- (instancetype) init;

@end
