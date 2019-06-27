//
//  MISTrainData.h
//  exportProject
//
//  Created by liu on 2019/4/23.
//  Copyright © 2019 liu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MISTrainData : NSObject
@property (nonatomic,copy)NSString *cpm;
@property (nonatomic,copy)NSString *heartbeat;
@property (nonatomic,copy)NSString *lessonStartTime;
@property (nonatomic,copy)NSString *lessonEndTime;
@property (nonatomic,copy)NSString *studentId;
@property (nonatomic,copy)NSString *studentName;
@property (nonatomic,assign)NSInteger valueCount;


@end

NS_ASSUME_NONNULL_END
