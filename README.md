VideoRecorder
================
Needs more work. (More work, by Daniel Burke)

This is a fine video recorder by [Kseniya Zito](https://github.com/Kseniya "Her Github Account").  I'm taking the time to add a few convenience methods that will allow for more flexible UI implementations.

Some of the options I'll be adding:

* Attach long press gesture (for recording) to video preview layer
* Attach long press gesture to any other UIView
* Attach deleteLastAsset to any other UIView
* Attach progress to any other UIView
* and more.

Find All original Documentation Below
------------------------

Vine like video recorder. Hold you finger - record, let it go - stop recording.
Ability to switch between front and back camera, plus deleting last recorded piece.

Based around Apple's AVCam sample code.


Can be imoported to other project by copying VideoRecorder folder. 
Add Camera View into you view controller 

        self.cam = [[KZCameraView alloc]initWithFrame:self.view.frame withVideoPreviewFrame:CGRectMake(0.0, 0.0, 320.0, 320.0)];
        [self.view addSubview:self.cam];
       
Set max duration of the video

       self.cam.maxDuration = 10.0;

Create a button (in example project bar button) to save recorded video.

       self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self. action:@selector(saveVideo:)];

Use saveVideoWithCompletionBlock: method to save the video and do something after it gets saved

    -(IBAction)saveVideo:(id)sender
    {
      [self.cam saveVideoWithCompletionBlock:^(BOOL success) {
        if (success)
        {
        //Do something after video got succesfully saved
        }
    }];
   }
