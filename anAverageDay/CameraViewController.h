//
//  CameraViewController.h
//  anAverageDay
//
//  Created by esther on 4/10/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol cameraViewDelegate <NSObject>

- (void) cameraViewControllerDismissed:(UIImageView *)imageViewToPass;

@end

@interface CameraViewController : UIViewController

@property (nonatomic, retain) AVCaptureDevice *device;
@property (nonatomic, retain) AVCaptureSession *session;
@property (nonatomic, retain) AVCaptureVideoPreviewLayer *videoLayer;
@property (nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, retain) AVCaptureConnection *captureConnection;
@property (nonatomic, retain) UIImage *stillImage;

@property (nonatomic, retain) IBOutlet UIView *imagePreview;
@property (strong, nonatomic) IBOutlet UIButton *cameraButton;
@property (nonatomic, retain) UIImageView *imageView;

@property (nonatomic, assign) id <cameraViewDelegate> cameraDelegate;

//- (IBAction)captureNow;

@end
