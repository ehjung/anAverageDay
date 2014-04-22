//
//  ResizeImage.h
//  anAverageDay
//
//  Created by esther on 4/21/14.
//  Copyright (c) 2014 ehjung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResizeImage : NSObject

@property (strong, nonatomic) UIImage *resizedImage;
@property (strong, nonatomic) UIImage *originalImage;

@property (nonatomic) CGFloat originalImageWidth;
@property (nonatomic) CGFloat originalImageHeight;
@property (nonatomic) CGFloat targetImageWidth;
@property (nonatomic) CGFloat targetImageHeight;

@property (nonatomic) CGFloat widthFactor;
@property (nonatomic) CGFloat heightFactor;
@property (nonatomic) CGFloat scaleFactor;
@property (nonatomic) CGFloat scaledWidth;
@property (nonatomic) CGFloat scaledHeight;

@property (nonatomic) CGPoint imageCenterPoint;

+ (id)sharedResizeImage;
- (UIImage *)resizeImage:(UIImage *)imageToResize targetHeight:(CGFloat)targetHeight targetWidth:(CGFloat)targetWidth;

@end
