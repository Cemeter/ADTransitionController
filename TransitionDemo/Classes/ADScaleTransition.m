//
//  ADScaleTransition.m
//  ADTransitionController
//
//  Created by Pierre Felgines on 28/05/13.
//  Copyright (c) 2013 Applidium. All rights reserved.
//

#import "ADScaleTransition.h"

@implementation ADScaleTransition

- (id)initWithDuration:(CFTimeInterval)duration orientation:(ADTransitionOrientation)orientation sourceRect:(CGRect)sourceRect {
    self = [super init];
    if (self != nil) {
        const CGFloat viewWidth = sourceRect.size.width;
        const CGFloat viewHeight = sourceRect.size.height;
        CABasicAnimation * inSwipeAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        inSwipeAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        switch (orientation) {
            case ADTransitionRightToLeft:
            {
                inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(viewWidth, 0.0f, 0.0f)];
            }
                break;
            case ADTransitionLeftToRight:
            {
                inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(- viewWidth, 0.0f, 0.0f)];
            }
                break;
            case ADTransitionTopToBottom:
            {
                inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, - viewHeight, 0.0f)];
            }
                break;
            case ADTransitionBottomToTop:
            {
                inSwipeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0.0f, viewHeight, 0.0f)];
            }
                break;
            default:
                NSAssert(FALSE, @"Unhandled ADTransitionOrientation");
                break;
        }
        
        CABasicAnimation * outOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        outOpacityAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
        outOpacityAnimation.toValue = [NSNumber numberWithFloat:0.0f];
        
        CABasicAnimation * outPositionAnimation = [CABasicAnimation animationWithKeyPath:@"zPosition"];
        outPositionAnimation.fromValue = [NSNumber numberWithDouble:-0.001f];
        outPositionAnimation.toValue = [NSNumber numberWithDouble:-0.001f];
        outPositionAnimation.duration = duration;
        
        CABasicAnimation * outScaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
        outScaleAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        outScaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.8f, 0.8f, 1.0f)];
        outScaleAnimation.duration = duration;
        
        CAAnimationGroup * outAnimation = [CAAnimationGroup animation];
        [outAnimation setAnimations:@[outOpacityAnimation, outPositionAnimation, outScaleAnimation]];
        
        _inAnimation = inSwipeAnimation;
        _outAnimation = outAnimation;
        _inAnimation.duration = duration;
        _outAnimation.duration = duration;
        [_inAnimation retain];
        [_outAnimation retain];
        [self finishInit];
    }
    return self;
}

@end