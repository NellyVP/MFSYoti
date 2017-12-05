//
//  CALayer+ShadedRoundedLayer.m
//  JustCallMe
//
//  Created by Nilofar Vahab poor on 28/07/2016.
//  Copyright © 2016 Voxygen Ltd. All rights reserved.
//

#import "CALayer+ShadedRoundedLayer.h"
#import <UIKit/UIKit.h>

@implementation CALayer (ShadedRoundedLayer)

- (void) makeShadedRoundedWithCornerRadius:(CGFloat)radius borderColor:(UIColor*)color  {
    self.masksToBounds = NO;
    self.cornerRadius = radius;
    self.borderColor = color.CGColor;
    self.shadowOffset = CGSizeMake(3, 3);
    self.shadowColor = color.CGColor;
    self.shadowOpacity = 0.1;
    self.shadowRadius = 0.4;
    self.shouldRasterize = YES;
    self.rasterizationScale = UIScreen.mainScreen.scale;
}

@end
