//
//  MISUtils.h
//  ZTBLEDemo
//
//  Created by mao on 2018/6/28.
//  Copyright © 2018 mao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MISRecord.h"

@interface MISUtils : NSObject

+ (NSString *)documentfilePath:(NSString *) fileName;
+ (NSString *)stringWithDate:(NSDate *)date;

+ (NSData *)picDataWithName:(NSString *)name;
+ (NSString *)wifiIp4Address;
+ (NSString *)fileStringWithDate:(NSDate *)date;

+ (void )outputToCSVFilePathWithRecord:(MISRecord *)record filePath:(NSString *)filePath;

@end
