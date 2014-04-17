//
//  CameraViewController.m
//  anAverageDay
//
//  Created by esther on 4/10/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import "CameraViewController.h"
#import "FormViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.session = [[AVCaptureSession alloc] init];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 180)];
        
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    self.session.sessionPreset = AVCaptureSessionPresetMedium;
    self.videoLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    
    self.videoLayer.frame = self.imagePreview.bounds;
    [self.imagePreview.layer addSublayer:self.videoLayer];
    
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	
	NSError *error = nil;
	AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
	if (!input) {
		NSLog(@"ERROR: trying to open camera: %@", error);
	}
	[self.session addInput:input];
    
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    [self.session addOutput:self.stillImageOutput];
    
    [self.session startRunning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)captureNow {
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.stillImageOutput.connections)
	{
		for (AVCaptureInputPort *port in [connection inputPorts])
		{
			if ([[port mediaType] isEqual:AVMediaTypeVideo] )
			{
				videoConnection = connection;
				break;
			}
		}
		if (videoConnection) { break; }
	}
	
	[self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error)
     {
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *image = [[UIImage alloc] initWithData:imageData];
         [self.imageView setImage:image];
	 }];
//    [self.cameraDelegate cameraViewControllerDismissed:self.imageView];
//    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    NSLog(@"Test");
    // Pass the selected object to the new view controller.
}
*/
    
@end
