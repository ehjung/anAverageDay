//
//  CameraViewController.m
//  anAverageDay
//
//  Created by esther on 4/10/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import "CameraViewController.h"
#import "FormViewController.h"
#import "ResizeImage.h"

@interface CameraViewController ()

@end

@implementation CameraViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.session = [[AVCaptureSession alloc] init];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 275, 175)];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *buttonImage = [UIImage imageNamed:@"button.png"];
    [self.cameraButton setImage:buttonImage forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
    [self videoSetup];
	[self addInputDevice];
    
    // add output
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    [self.session addOutput:self.stillImageOutput];
    
    [self.session startRunning];
}

- (void)videoSetup {
    // set up video session and video preview layer
    self.session.sessionPreset = AVCaptureSessionPresetMedium;
    self.videoLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
    self.videoLayer.frame = self.imagePreview.bounds;
    [self.imagePreview.layer addSublayer:self.videoLayer];
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
}

- (void)addInputDevice {
    NSError *error = nil;
	AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
	if (!input) {
		NSLog(@"ERROR: trying to open camera: %@", error);
	}
	[self.session addInput:input];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)captureNow {
    for (AVCaptureConnection *connection in self.stillImageOutput.connections) {
		for (AVCaptureInputPort *port in [connection inputPorts]) {
			if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
				self.captureConnection = connection;
				break;
			}
		}
		if (self.captureConnection) { break; }
	}
    [self convertToStillImage];
}

- (void)convertToStillImage {
    // AVCapture image to imageView image
	[self.stillImageOutput captureStillImageAsynchronouslyFromConnection:self.captureConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        image = [[ResizeImage sharedResizeImage] resizeImage:image targetHeight:175 targetWidth:275];
        [self.imageView setImage:image];
    }];
}
   
@end
