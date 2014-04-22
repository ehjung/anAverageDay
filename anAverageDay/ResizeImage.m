//
//  resizeImage.m
//  anAverageDay
//
//  Created by esther on 4/21/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import "ResizeImage.h"

@implementation ResizeImage


#pragma mark - singleton methods

+ (id)sharedResizeImage {
    static ResizeImage *sharedResizeImage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedResizeImage = [[self alloc] init];
    });
    return sharedResizeImage;
}

- (id)init {
    if (self = [super init]) {
        self.originalImage = [[UIImage alloc] init];
    }
    return self;
}

- (UIImage *)resizeImage:(UIImage *)imageToResize targetHeight:(CGFloat)targetHeight targetWidth:(CGFloat)targetWidth{
    self.originalImageWidth = imageToResize.size.width;
    self.originalImageHeight = imageToResize.size.height;
    self.targetImageWidth = targetWidth;
    self.targetImageHeight = targetHeight;
    self.originalImage = imageToResize;
    
    [self calculateImageScale];
    [self calculateImageCenter];
    return [self drawImage];
}

- (void)calculateImageScale {
    self.widthFactor = self.targetImageWidth / self.originalImageWidth;
    self.heightFactor = self.targetImageHeight / self.originalImageHeight;
    if (self.widthFactor > self.heightFactor) {
        self.scaleFactor = self.widthFactor;
    } else {
        self.scaleFactor = self.heightFactor;
    }
    self.scaledWidth = self.originalImageWidth * self.scaleFactor;
    self.scaledHeight = self.originalImageHeight * self.scaleFactor;
    
}

- (void)calculateImageCenter {
    CGPoint imagePoint = CGPointMake(0, 0);
    if (self.widthFactor > self.heightFactor) {
        imagePoint.y = (self.targetImageHeight - self.scaledHeight) * 0.5;
    } else if (self.widthFactor < self.heightFactor) {
        imagePoint.x = (self.targetImageWidth - self.scaledWidth) * 0.5;
    }
    self.imageCenterPoint = imagePoint;
}

- (UIImage *)drawImage {
    CGSize targetSize = CGSizeMake(self.targetImageWidth, self.targetImageHeight);
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectMake(self.imageCenterPoint.x, self.imageCenterPoint.y, self.scaledWidth, self.scaledHeight);
    [self.originalImage drawInRect:thumbnailRect];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

@end
