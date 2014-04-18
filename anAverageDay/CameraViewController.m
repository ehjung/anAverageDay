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
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 275, 175)];
        
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
         image = [self scaleThenCropImage:image];
         [self.imageView setImage:image];
	 }];
}

- (UIImage *)scaleThenCropImage:(UIImage *)image {
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat targetWidth = 275;
    CGFloat targetHeight = 175;
    CGFloat scaleFactor;
    CGSize targetSize = CGSizeMake(275, 175);
    
    CGFloat widthFactor = targetWidth / width;
    CGFloat heightFactor = targetHeight / height;
    if (widthFactor > heightFactor) {
        scaleFactor = widthFactor;
    } else {
        scaleFactor = heightFactor;
    }
    
    CGFloat scaledWidth = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    CGPoint thumbnailPoint = CGPointMake(0, 0);
    if (widthFactor > heightFactor)
    {
        thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
    }
    else
    {
        if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectMake(thumbnailPoint.x, thumbnailPoint.y, scaledWidth, scaledHeight);
    [image drawInRect:thumbnailRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}
   
@end
