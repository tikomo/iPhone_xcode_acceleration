//
//  ViewController.m
//  Aacceleration
//
//  Created by tikomo on 2013/11/12.
//  Copyright (c) 2013年 tikomo. All rights reserved.
//

#import <CoreMotion/CoreMotion.h> // add
#import "ViewController.h"

@interface ViewController (){
    CMMotionManager *manager;
}

// CMMotionManager *manager; // ここでもいい

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // 周波数(Hz)
    int frequency = 50;
    
    manager = [[CMMotionManager alloc] init];
    
    // CMAccelerometerDataの開始
    [self startCMAccelerometerData:frequency];
}

- (void)startCMAccelerometerData:(int)frequency
{
    // 加速度センサーの有無を確認
    if (manager.accelerometerAvailable) {
        
        self.label1.text = @"加速度センサー有効";
        
        // 更新間隔の指定
        manager.accelerometerUpdateInterval = 1 / frequency;  // 秒
        // ハンドラ
        CMAccelerometerHandler handler = ^(CMAccelerometerData *data, NSError *error) {
            // double timestamp = data.timestamp;
            self.textX.text = [NSString stringWithFormat:@"%lf", data.acceleration.x];
            self.textY.text = [NSString stringWithFormat:@"%lf", data.acceleration.y];
            self.textZ.text = [NSString stringWithFormat:@"%lf", data.acceleration.z];
        };
        // センサーの利用開始
        [manager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:handler];
    } else {
        self.label1.text = @"加速度センサー無効";
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
