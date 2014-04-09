//
//  CustomRecorderViewController.h
//  NewVideoRecorder
//
//  Created by Daniel.Burke on 4/9/14.
//  Copyright (c) 2014 KZito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KZCameraView.h"

@interface CustomRecorderViewController : UIViewController <UIGestureRecognizerDelegate>

//
@property (nonatomic) CGFloat viewWidth;
@property (nonatomic) CGFloat viewHeight;

//UI
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@property (nonatomic, strong) KZCameraView *cam;

@end
