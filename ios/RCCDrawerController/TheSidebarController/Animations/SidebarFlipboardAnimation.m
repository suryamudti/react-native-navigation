// SidebarFlipboardAnimation.m
// TheSidebarController
//
// Copyright (c) 2014 Jon Danao (danao.org | jondanao)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "SidebarFlipboardAnimation.h"

@implementation SidebarFlipboardAnimation

+ (void)animateContentView:(UIView *)contentView sidebarView:(UIView *)sidebarView fromSide:(Side)side visibleWidth:(CGFloat)visibleWidth duration:(NSTimeInterval)animationDuration completion:(void (^)(BOOL))completion
{
    [self resetSidebarPosition:sidebarView];
    [self resetContentPosition:contentView];
    
    
    CGRect sidebarFrame = sidebarView.frame;
    [sidebarView.superview bringSubviewToFront:sidebarView];
    
    CATransform3D contentTransform = CATransform3DIdentity;
    contentTransform = CATransform3DScale(contentTransform, 0.9, 0.9, 0.9);
    
    if(side == LeftSide)
    {
        sidebarFrame.origin.x = -sidebarFrame.size.width;
        sidebarView.frame = sidebarFrame;
        sidebarFrame.origin.x += visibleWidth;
    }
    else
    {
        sidebarFrame.origin.x = sidebarFrame.size.width;
        sidebarView.frame = sidebarFrame;
        sidebarFrame.origin.x -= visibleWidth;
    }
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         sidebarView.frame = sidebarFrame;
                         contentView.alpha = 0.3;
                         contentView.layer.transform = contentTransform;
                     }
                     completion:^(BOOL finished) {
                         completion(finished);
                     }];
    
    
    
}

+ (void)reverseAnimateContentView:(UIView *)contentView sidebarView:(UIView *)sidebarView fromSide:(Side)side visibleWidth:(CGFloat)visibleWidth duration:(NSTimeInterval)animationDuration completion:(void (^)(BOOL))completion
{
    CGRect sidebarFrame = sidebarView.frame;
    CATransform3D contentTransform = CATransform3DIdentity;
    contentTransform = CATransform3DScale(contentTransform, 1.0, 1.0, 1.0);
    
    if(side == LeftSide)
    {
        sidebarFrame.origin.x -= visibleWidth;
    }
    else
    {
        sidebarFrame.origin.x += visibleWidth;
    }
    
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         sidebarView.frame = sidebarFrame;
                         contentView.alpha = 1;
                         contentView.layer.transform = contentTransform;
                     }
                     completion:^(BOOL finished) {
                         completion(finished);
                     }];
}


@end
