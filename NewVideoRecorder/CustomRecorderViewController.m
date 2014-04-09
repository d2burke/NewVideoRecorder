//
//  CustomRecorderViewController.m
//  NewVideoRecorder
//
//  Created by Daniel.Burke on 4/9/14.
//  Copyright (c) 2014 KZito. All rights reserved.
//

#import "CustomRecorderViewController.h"

@interface CustomRecorderViewController ()

@end

@implementation CustomRecorderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _viewWidth = self.view.frame.size.width;
    _viewHeight = self.view.frame.size.height;
    
    //Create CameraView
	_cam = [[KZCameraView alloc]initWithFrame:CGRectMake(0.0, 0.0, _viewWidth, _viewHeight - 64.0) withVideoPreviewFrame:CGRectMake(0.0, 0.0, _viewWidth, _viewWidth)];
    _cam.maxDuration = 10.0;
    [self.view addSubview:_cam];
    
    //Initialize long press for preview view
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(startRecording:)];
    [_longPress setDelegate:self];
    [_cam.videoPreviewView addGestureRecognizer:_longPress];
    
    //Get first frame and add it to this button
    _imagePreviewButton = [[UIBarButtonItem alloc] initWithTitle:@"Preview" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = _imagePreviewButton;
    
    //Add Save button to nav
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveVideo:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - KZCam Methods
-(void)startRecording:(UILongPressGestureRecognizer*)gestureRecognizer{
    [_cam startRecording:gestureRecognizer];
}

-(IBAction)saveVideo:(id)sender
{
    [_cam saveVideoWithCompletionBlock:^(BOOL success) {
        if (success)
        {
            NSLog(@"Get First frame of video for display");
        }
    }];
}

@end
