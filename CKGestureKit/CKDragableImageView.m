//
//  CKDragableImageView.m
//  CKGestureKit
//
//  Created by Richard Lichkus on 8/14/14.
//  Copyright (c) 2014 Richard Lichkus. All rights reserved.
//

#import "CKDragableImageView.h"

@interface CKDragableImageView () <UIGestureRecognizerDelegate>
{
    CGFloat tx;
    CGFloat ty;
    CGFloat scale;
    CGFloat adjustedScale;
    CGFloat theta;
    CGFloat adjustedTheta;
}

@end

@implementation CKDragableImageView

#pragma mark - Instantiation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (id) initWithImage:(UIImage *)image
{
    // Initialize and set as touchable
    if (self)
    {
        self = [super initWithImage:image];
        self.userInteractionEnabled = YES;
        
        // Initialize
        self.transform = CGAffineTransformIdentity;
        tx = 0.0f;
        ty = 0.0f;
        scale = 1.0f;
        adjustedScale = 1.0f;
        theta = 0.0f;
        adjustedTheta = 0.0f;
        
        // Add gesture recognizers
        UIRotationGestureRecognizer *rot = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotation:)];
        rot.delegate = self;
        [self addGestureRecognizer:rot];
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        pinch.delegate = self;
        [self addGestureRecognizer:pinch];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
        pan.minimumNumberOfTouches = 2;
        pan.delegate = self;
        [self addGestureRecognizer:pan];
    }
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.superview bringSubviewToFront:self];

    tx = self.transform.tx;
    ty = self.transform.ty;
}

- (void) updateTransformWithOffset: (CGPoint) translation
{
    // Update transform
    self.transform = CGAffineTransformMakeTranslation(translation.x + tx, translation.y + ty);
    self.transform = CGAffineTransformRotate(self.transform, theta);
    self.transform = CGAffineTransformScale(self.transform, scale, scale);
}

- (void) handlePan: (UIPanGestureRecognizer *) uigr
{
    CGPoint translation = [uigr translationInView:self.superview];
    [self updateTransformWithOffset:translation];
}

- (void) handleRotation: (UIRotationGestureRecognizer *) uigr
{
    if(uigr.state == UIGestureRecognizerStateChanged){
        theta = adjustedTheta+uigr.rotation;
        [self updateTransformWithOffset:CGPointZero];
    } else if (uigr.state == UIGestureRecognizerStateEnded){
        adjustedTheta = theta;
    }
}

- (void) handlePinch: (UIPinchGestureRecognizer *) uigr
{
    if(uigr.state == UIGestureRecognizerStateChanged){
        scale = adjustedScale*uigr.scale;
        [self updateTransformWithOffset:CGPointZero];
    }
    if(uigr.state == UIGestureRecognizerStateEnded){
        adjustedScale = scale;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:
(UIGestureRecognizer *)otherGestureRecognizer

{
    return YES;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return NO;
}

@end
