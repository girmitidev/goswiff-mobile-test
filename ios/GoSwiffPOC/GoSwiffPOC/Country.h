//
//  Country.h
//  GoSwiff POC
//
//  Created by Girmiti Dev on 14/7/16.
//  Copyright (c) 2016 Girmiti Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Country : NSObject

@property (nonatomic, strong) NSString *_code3L;
@property (nonatomic, strong) NSString *_code2L;
@property (nonatomic, strong) NSString *_name;
@property (nonatomic, strong) NSString *_nameOfficial;
@property (nonatomic, strong) NSString *_flag32;
@property (nonatomic, strong) NSString *_flag128;
@property (nonatomic, strong) NSString *_latitude;
@property (nonatomic, strong) NSString *_logitude;

@end
