//
//  MISUtils.m
//  ZTBLEDemo
//
//  Created by mao on 2018/6/28.
//  Copyright © 2018 mao. All rights reserved.
//

#import "MISUtils.h"
#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <ifaddrs.h>
#include <netdb.h>
#include <unistd.h>
#import "MISTrainData.h"
//#import "MISDataUnit.h"
//#import "MISDateUtils.h"

@implementation MISUtils


+ (NSString *)documentfilePath:(NSString *) fileName {
	if(fileName == nil)
		return nil;
	
	NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString* documentsDirectory = [paths objectAtIndex: 0];
	NSString* documentsPath = [documentsDirectory stringByAppendingPathComponent: fileName];
	
	return documentsPath;
}

+ (NSString *)stringWithDate:(NSDate *)date {
	NSDateFormatter* dataFmt = [[NSDateFormatter alloc] init];
	[dataFmt setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
	return [dataFmt stringFromDate:date];
}

+ (NSString *)fileStringWithDate:(NSDate *)date {
	NSDateFormatter* dataFmt = [[NSDateFormatter alloc] init];
	[dataFmt setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
	return [dataFmt stringFromDate:date];
}

+ (NSString *)wifiIp4Address {
	struct ifaddrs *ifaddr, *ifa;
	char host[NI_MAXHOST];
	
	if (getifaddrs(&ifaddr) == -1) {
		return @"";
	}
	
	for (ifa = ifaddr; ifa != NULL; ifa = ifa->ifa_next) {
		if (ifa->ifa_addr == NULL) {
			continue;
		}
		
		socklen_t addr_len = 0;
		if (ifa->ifa_addr->sa_family == AF_INET && strcmp(ifa->ifa_name, "en0") == 0) {
			addr_len = sizeof(struct sockaddr_in);
			getnameinfo(ifa->ifa_addr,
						addr_len,
						host, NI_MAXHOST,
						NULL,
						0,
						NI_NUMERICHOST);
			break;
		}
	}
	
	freeifaddrs(ifaddr);
	
	return [NSString stringWithUTF8String:host];
}



///*文字转图片*/
//+ (UIImage *)imageWithName:(NSString *)name {
//    CGSize size = CGSizeMake(96, 88);
//    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
//    label.text = name;
//    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:40.0f];
//    label.backgroundColor = UIColor.blackColor;
//    label.textColor = UIColor.whiteColor;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.adjustsFontSizeToFitWidth = YES;
//    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
//    [label.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return image;
//}
//
///*图片转数据*/
//+ (NSData *)picDataWithImage:(UIImage *)image {
//    //input image must be 96 * 88
//    if (!CGSizeEqualToSize(image.size, CGSizeMake(96, 88))) {
//        return nil;
//    }
//
//    size_t bufferSize = 96 * 88 / 8;
//    CGImageRef imageRef = image.CGImage;
//    CGDataProviderRef providerRef = CGImageGetDataProvider(imageRef);
//    CFDataRef dataRef =  CGDataProviderCopyData(providerRef);
//
//    //RGBA 距阵 - 白色单色图，只须判断 R 值即可。
//    const UInt8 * rgbPtr = CFDataGetBytePtr(dataRef);
//    size_t size = CFDataGetLength(dataRef);
//
//    UInt8 buffer[bufferSize];
//    int i = 0;
//    int k = 0;
//    int j = 0;
//    UInt8 value = 0x00;
//    while (i < size) {
//        if (rgbPtr[i] > 0x50
//            && rgbPtr[i+1] > 0x50
//            && rgbPtr[i+2] > 0x50) {
//            value |= 1;
//        }
//        k++;
//        k = k % 8;
//        if (k == 0) {
//            buffer[j++] = value;
//            value = 0;
//        }
//        value = value << 1;
//        i += 4; //RGBA 4 bytes
//    }
//
//    CFRelease(dataRef);
//
//    return [NSData dataWithBytes:buffer length:bufferSize];
//}
//
//+ (NSData *)picDataWithName:(NSString *)name {
//    return [self picDataWithImage:[self imageWithName:name]];
//}

//+ (void )outputToCSVFilePathWithRecord:(MISRecord *)record filePath:(NSString *)filePath {
//    NSLog(@"filePath:%@",filePath);
//
//    NSMutableString* outputString = [NSMutableString string];
//    NSMutableString* line1s = [NSMutableString string];
//    NSMutableString* line2s = [NSMutableString string];
//
//    NSString* nnnname = nil;
//
//    //表头信息
//    for (MISTrainData* data in record.sportData) {
//        [line1s appendString:data.studentId];
//        [line1s appendString:@","];
//        [line1s appendString:data.studentName];
//        [line1s appendString:@","];
//        [line1s appendString:data.studentName];
//        [line1s appendString:@","];
//        nnnname = data.studentName;
//        [line2s appendString:@"TIME,HR,CPM,"];
//    }
//
//    [outputString appendString:line1s];
//    [outputString appendString:@"\n"];
//
//    [outputString appendString:line2s];
//    [outputString appendString:@"\n"];
//
//
//    //找到最小个数
//    MISTrainData* firstObj = record.sportData.firstObject;
//    NSInteger minCount = firstObj.valueCount;
////    for (MISTrainData* data in record.sportData) {
////        if (minCount > data.heartbeat.count)
////            minCount = data.heartbeat.count;
////    }
//
//    NSArray *heartBeatArray = [firstObj.heartbeat componentsSeparatedByString:@","];
//    NSArray *cpmArray = [firstObj.cpm componentsSeparatedByString:@","];
//
//    //逐行开始
//    for (int i = 0; i < minCount; ++i) {
//        NSMutableString* lineX = [NSMutableString string];
//        for (MISTrainData* data in record.sportData) {
////            MISDataUnit* unit = data.units[i];
////            NSString* timeString = [MISDateUtils stringFromDate:unit.time fmt:@"yyyy-MM-dd HH-mm-ss"];
//            NSString *hB = [heartBeatArray[i] string];
//            NSString *cp = [cpmArray[i] string];
//
//            NSString *startTimeString = data.lessonStartTime;
//            [lineX appendFormat:@"%@,%@,%@,", startTimeString, hB, cp];
//        }
//        [outputString appendString:lineX];
//        [outputString appendString:@"\n"];
//    }
//
//    //for windows GBK
//    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//
//
//    //delete old
//    if ([NSFileManager.defaultManager fileExistsAtPath:filePath]) {
//        [NSFileManager.defaultManager removeItemAtPath:filePath error:nil];
//    }
//    [outputString writeToFile:filePath atomically:YES encoding:encoding error:nil];
//
//    //for linux
//    //    [outputString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
//}

+ (void )outputToCSVFilePathWithRecord:(MISRecord *)record filePath:(NSString *)filePath {
    NSLog(@"%s filePath:%@",__func__,filePath);
    
    NSMutableString* outputString;
    
    NSString* nnnname = nil;
    
    //表头信息
    for (MISTrainData* data in record.sportData) {
        outputString = [NSMutableString string];
        
        NSMutableString* line1s = [NSMutableString string];
        NSMutableString* line2s = [NSMutableString string];
        
        [line1s appendString:data.studentId];
        [line1s appendString:@","];
        [line1s appendString:data.studentName];
        [line1s appendString:@","];
        [line1s appendString:data.studentName];
        [line1s appendString:@","];
        nnnname = data.studentName;
        [line2s appendString:@"TIME,Heart Rate (bpm),CPM,"];
        
        [outputString appendString:line1s];
        [outputString appendString:@"\n"];
        
        [outputString appendString:line2s];
        [outputString appendString:@"\n"];
        
        NSString *startTimeString = data.lessonStartTime;
        NSLog(@"%s studentId:%@ startTime:%@",__func__,data.studentName,data.lessonStartTime);
        
        NSArray *heartBeatArray = [data.heartbeat componentsSeparatedByString:@","];
        NSArray *cpmArray = [data.cpm componentsSeparatedByString:@","];
        
        NSInteger minCount = data.valueCount;
        
        //逐行开始
        for (int i = 0; i < minCount; ++i) {
            NSMutableString* lineX = [NSMutableString string];
            //            MISDataUnit* unit = data.units[i];
            //            NSString* timeString = [MISDateUtils stringFromDate:unit.time fmt:@"yyyy-MM-dd HH-mm-ss"];
            
            NSString *hB = [NSString stringWithFormat:@"%@",heartBeatArray[i]];
            NSString *cp = [NSString stringWithFormat:@"%@",cpmArray[i]];
            
            
            [lineX appendFormat:@"%@,%@,%@,", startTimeString, hB, cp];
            
            [outputString appendString:lineX];
            [outputString appendString:@"\n"];
            
        }
        
        NSString *filePath1 = [filePath stringByAppendingFormat:@"%@.csv",data.studentName];
        
        NSLog(@"%s filePath:%@",__func__,filePath);
        
        //for windows GBK
        NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        //delete old
        if ([NSFileManager.defaultManager fileExistsAtPath:filePath1]) {
            [NSFileManager.defaultManager removeItemAtPath:filePath1 error:nil];
        }
        
        [outputString writeToFile:filePath1 atomically:YES encoding:encoding error:nil];
    }
    
    //找到最小个数
    //    MISTrainData* firstObj = record.sportData.firstObject;
    //    for (MISTrainData* data in record.sportData) {
    //        if (minCount > data.heartbeat.count)
    //            minCount = data.heartbeat.count;
    //    }
    
    //for linux
    //    [outputString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}


@end
