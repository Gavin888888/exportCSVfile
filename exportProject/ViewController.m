//
//  ViewController.m
//  exportProject
//
//  Created by liu on 2019/4/23.
//  Copyright © 2019 liu. All rights reserved.
//

#import "ViewController.h"
#import "MISUtils.h"
#import "NSObject+YYModel.h"


@interface ViewController ()
@property (nonatomic,strong)NSFileHandle *fileHandle;
@property (nonatomic,strong)NSOutputStream *outputStream;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self readFile];
    
//    [self appendDataToFile];
}

- (void)readFile {
    NSError *error;
    NSString *fileText = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"qinghuafuzhong0515" ofType:@"txt"] encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"--textFieldContents---%@-----",fileText);
    if (fileText==nil) {
        NSLog(@"---error--%@",[error localizedDescription]);
    }
    
//    NSArray *lines = [fileText componentsSeparatedByString:@"\n"];
//    NSLog(@"number of lines in the file:%ld",[lines count]);

    MISRecord* obj = [MISRecord yy_modelWithJSON:fileText];

    NSLog(@"%s obj.name:%@",__func__,obj.lessonName);
    
    

//    NSData *fileData = [NSData dataWithContentsOfFile:filepath];
//
//    NSString *filename1 = [NSString stringWithFormat:@"%@_unzip.txt",@(i)];
//
    NSString *filePath = [MISUtils documentfilePath:@"/train"];
    

    [MISUtils outputToCSVFilePathWithRecord:obj filePath:filePath];
}

- (void)appendDataToFile {
    NSString *fileName = [MISUtils documentfilePath:@"1.txt"];
    NSLog(@"%s fileName:%@",__func__,fileName);
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:fileName]) {
        [[NSFileManager defaultManager] createFileAtPath:fileName contents:nil attributes:nil];
    }
    
    self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:fileName];
    
    [self.fileHandle seekToEndOfFile];
    
    UIDevice *currentDevice = [UIDevice currentDevice];
    CGRect boundsRect = [UIApplication sharedApplication].keyWindow.screen.bounds;
    NSLog(@"screenWith:%@ screenHeight:%@",@(boundsRect.size.width),@(boundsRect.size.height));
    NSLog(@"currentDevice:%@",currentDevice);
    

    NSMutableString *outputString = [NSMutableString string];
    [outputString appendString:@"\n"];
    [outputString appendFormat:@"nowDate:%@",[NSDate date]];
    [outputString appendString:@"\n"];
    [outputString appendFormat:@"device.name:%@",currentDevice.name];
    [outputString appendString:@"\n"];
    [outputString appendFormat:@"device.systemName:%@",currentDevice.systemName];
    [outputString appendString:@"\n"];
    [outputString appendFormat:@"device.systemVersion:%@",currentDevice.systemVersion];
    
    [outputString appendString:@"\n"];
    [outputString appendFormat:@"width:%@ height:%@",@(boundsRect.size.width),@(boundsRect.size.height)];
    NSData *contentData = [outputString dataUsingEncoding:NSUTF8StringEncoding];
    [outputString appendString:@"\t\n"];

    [self.fileHandle writeData:contentData];
    [self.fileHandle closeFile];
}

- (void)testScreenSize {
 
}

#pragma mark getter and setter

@end
