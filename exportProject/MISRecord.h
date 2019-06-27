//
//  MISRecord.h
//  exportProject
//
//  Created by liu on 2019/4/23.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MISTrainData.h"

NS_ASSUME_NONNULL_BEGIN

@interface MISRecord : NSObject
@property (nonatomic,copy)NSString *lessonName;
@property (nonatomic,assign)NSInteger boyCount;
@property (nonatomic,assign)NSInteger girlCount;
@property (nonatomic,strong)NSArray<MISTrainData*> *sportData;


@end

NS_ASSUME_NONNULL_END
