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
    
    [[NSNotificationCenter defaultCenter]  addObserver:self
                                              selector:@selector(updateDuration:)
                                                  name:KZVideoProgressEvent
                                                object:nil];
    
    //Create CameraView
	_cam = [[KZCameraView alloc]initWithFrame:CGRectMake(0.0, 0.0, _viewWidth, _viewHeight - 64.0) withVideoPreviewFrame:CGRectMake(0.0, 0.0, _viewWidth, _viewWidth)];
    _cam.maxDuration = 10.0;
    [self.view addSubview:_cam];
    
    _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, _viewWidth-40, 0, 40)];
    _progressView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.2];
    [self.view addSubview:_progressView];
    
    //Initialize long press for preview view
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(startRecording:)];
    [_longPress setDelegate:self];
    [_cam.videoPreviewView addGestureRecognizer:_longPress];
    
    //Get first frame and add it to this button
    _deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStylePlain target:self action:@selector(deleteLast)];
    self.navigationItem.leftBarButtonItem = _deleteButton;
    
    //Add Save button to nav
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveVideo:)];
    
    //Add Save button to nav
    UIButton *cameraTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraTypeButton.frame = CGRectMake(0, 0, 44, 88);
    [cameraTypeButton setTitle:@"Front" forState:UIControlStateNormal];
    [cameraTypeButton addTarget:self action:@selector(switchCameraType:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = cameraTypeButton;
    
}

-(void)updateDuration:(NSNotification*)notification{
    //Handle duration notification event
    
    //TODO: Send back an array of duration values,
    //      instead of one continuous value so we can
    //      draw the pieces separately if desired
    
    CGFloat progress = [[[notification userInfo] objectForKey:@"progress"] floatValue];
    CGRect progressFrame = _progressView.frame;
    progressFrame.size.width = _viewWidth * progress;
    _progressView.frame = progressFrame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - KZCam Methods
-(void)switchCameraType:(id)sender{
    [_cam switchCamera:self];
}

-(void)startRecording:(UILongPressGestureRecognizer*)gestureRecognizer{
    [_cam startRecording:gestureRecognizer];
}

-(void)deleteLast{
    [_cam deleteLastAsset];
}

-(IBAction)saveVideo:(id)sender
{
    [_cam saveVideoWithCompletionBlock:^(BOOL success) {
        if (success)
        {
            //Display first frame somewhere
            //<UIImage> _cam.firstFrame
        }
    }];
}

@end
