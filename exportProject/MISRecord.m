//
//  MISRecord.m
//  exportProject
//
//  Created by liu on 2019/4/23.
//  Copyright © 2019 liu. All rights reserved.
//

#import "MISRecord.h"

@implementation MISRecord

/**yymode**/
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
             @"sportData" : MISTrainData.class
             };
}

@end
